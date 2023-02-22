import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter_blue/flutter_blue.dart' as blue;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as blueS;
import 'package:iboxpro_flutter/iboxpro_flutter.dart';

class Iboxpro {
  static const String _terminalNamePrefix = 'MPOS';
  Duration _searchTimeout = Duration(seconds: 5);
  String? _deviceName;
  Map<String, dynamic>? _transaction;
  String? _transactionId;

  Iboxpro();

  Future<void> apiLogin({
    required String login,
    required String password,
    required Function onError,
    required Function onLogin
  }) async {
    await PaymentController.login(
      email: login,
      password: password,
      onLogin: (Result res) async {
        int errorCode = res.errorCode;

        if (errorCode == 0) {
          onLogin.call();
        } else {
          onError.call('Ошибка авторизации $errorCode');
        }
      }
    );
  }

  Future<void> connectToDevice({
    required Function(String) onError,
    required Function() onConnected
  }) async {
    if (!(await blue.FlutterBlue.instance.isOn)) {
      onError.call('Не включен Bluetooth');

      return;
    }

    try {
      _deviceName = await (Platform.isIOS ? _findBTDeviceNameIos() : _findBTDeviceNameAndroid());
    } catch(e) {
      onError.call('Ошибка при установлении связи с терминалом');

      return;
    }

    if (_deviceName == null) {
      onError.call('Не удалось найти терминал');

      return;
    }

    await PaymentController.startSearchBTDevice(
      deviceName: _deviceName!,
      onReaderSetBTDevice: onConnected
    );
  }

  Future<void> cancelPayment() async {
    await PaymentController.cancel();
  }

  Future<void> startPayment({
    required double amount,
    required String description,
    required Function onError,
    required Function onDisconnect,
    required Function onPaymentStart,
    required Function onPaymentComplete,
  }) async {
    await PaymentController.startPayment(
      amount: amount,
      description: description,
      inputType: InputType.NFC,
      singleStepAuth: true,
      onReaderEvent: (ReaderEvent res) async {
        if (res.type == ReaderEventType.Disconnected) {
          onDisconnect.call();
        }
      },
      onPaymentStart: (String id) async {
        _transactionId = id;
        onPaymentStart.call(_transactionId);
      },
      onPaymentError: (PaymentError res) async {
        int errorType = res.type;
        String errorMessage = res.message;

        onError.call('Ошибка обработки оплаты $errorType; $errorMessage');
      },
      onPaymentComplete: (Transaction transaction, bool requiredSignature) async {
        _transaction = transaction.toMap();
        _transaction!['deviceName'] = _deviceName;
        onPaymentComplete.call(_transaction, requiredSignature);
      }
    );
  }

  Future<void> adjustPayment({
    required Uint8List signature,
    required Function onError,
    required Function onPaymentAdjust
  }) async {
    await PaymentController.adjustPayment(
      id: _transactionId!,
      signature: signature,
      onPaymentAdjust: (Result res) async {
        int errorCode = res.errorCode;

        if (errorCode == 0) {
          onPaymentAdjust.call(_transaction);
        } else {
          onError.call('Ошибка сохранения подписи $errorCode');
        }
      }
    );
  }

  Future<void> startReversePayment({
    required String id,
    required double amount,
    required String description,
    required Function onError,
    required Function onDisconnect,
    required Function onPaymentStart,
    required Function onPaymentComplete,
  }) async {
    _transactionId = id;

    await PaymentController.startReversePayment(
      id: _transactionId!,
      amount: amount,
      description: description,
      inputType: InputType.NFC,
      singleStepAuth: true,
      onReaderEvent: (ReaderEvent res) async {
        if (res.type == ReaderEventType.Disconnected) {
          onDisconnect.call();
        }
      },
      onPaymentStart: (String id) async {
        _transactionId = id;
        onPaymentStart.call(_transactionId);
      },
      onPaymentError: (PaymentError res) async {
        int errorType = res.type;
        String errorMessage = res.message;

        onError.call('Ошибка обработки отмены оплаты $errorType; $errorMessage');
      },
      onPaymentComplete: (Transaction transaction, bool requiredSignature) async {
        _transaction = transaction.toMap();
        _transaction!['deviceName'] = _deviceName;
        onPaymentComplete.call(_transaction, requiredSignature);
      },
      onHistoryError: (Result res) async {
        onError.call('Ошибка получения информации об оплате ${res.errorCode}');
      },
      onReverseReject: () {
        onError.call('Данную оплату нельзя отменить');
      }
    );
  }

  Future<void> adjustReversePayment({
    required Uint8List signature,
    required Function onError,
    required Function onReversePaymentAdjust
  }) async {
    await PaymentController.adjustReversePayment(
      id: _transactionId!,
      signature: signature,
      onReversePaymentAdjust: (Result res) async {
        int errorCode = res.errorCode;

        if (errorCode == 0) {
          onReversePaymentAdjust.call();
        } else {
          onError.call('Ошибка сохранения подписи для отмены $errorCode');
        }
      }
    );
  }

  Future<String?> _findBTDeviceNameIos() async {
    blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
    List<blue.ScanResult> results = await flutterBlue.startScan(timeout: _searchTimeout);
    blue.BluetoothDevice? device = results.firstWhereOrNull(
      (blue.ScanResult result) => result.device.name.contains(_terminalNamePrefix)
    )?.device;

    if (device == null) {
      return null;
    }

    return device.name;
  }

  Future<String?> _findBTDeviceNameAndroid() async {
    blueS.FlutterBluetoothSerial bluetooth = blueS.FlutterBluetoothSerial.instance;

    List<blueS.BluetoothDiscoveryResult> results = [];
    StreamSubscription<blueS.BluetoothDiscoveryResult> subscription = bluetooth.startDiscovery().
      listen((r) => results.add(r));
    await Future.delayed(_searchTimeout);
    await subscription.cancel();

    List<blueS.BluetoothDevice> bondedDevices = await bluetooth.getBondedDevices();
    List<blueS.BluetoothDevice> localDevices = results.map((result) => result.device).toList();
    bool Function(blueS.BluetoothDevice) search = (device) => (device.name ?? '').contains(_terminalNamePrefix);

    blueS.BluetoothDevice? bondedDevice = bondedDevices.firstWhereOrNull(search);
    blueS.BluetoothDevice? localDevice = localDevices.firstWhereOrNull(search);
    blueS.BluetoothDevice? device = bondedDevice == localDevice ? bondedDevice : localDevice;

    if (device == null) return null;
    if (!device.isBonded) await bluetooth.bondDeviceAtAddress(device.address);

    return device.name;
  }
}
