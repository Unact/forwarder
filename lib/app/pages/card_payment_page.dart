import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart' as blue;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as blueSerial;
import 'package:iboxpro_flutter/iboxpro_flutter.dart';
import 'package:sentry/sentry.dart' as sentryLib;
import 'package:signature_pad/signature_pad.dart';
import 'package:signature_pad_flutter/signature_pad_flutter.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/modules/api.dart';
import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/models/user.dart';

class CardPaymentPage extends StatefulWidget {
  final List<Debt> debts;
  final Map<String, dynamic> location;

  CardPaymentPage({
    this.debts,
    this.location,
    Key key
  }) : super(key: key);

  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> with WidgetsBindingObserver {
  Duration _searchTimeout = Duration(seconds: 5);
  String _status = 'Ожидание';
  Map<dynamic, dynamic> _transaction;
  String _transactionId;
  String _iboxLogin;
  String _iboxPassword;
  bool _requiredSignature = false;
  bool _showCancelButton = true;
  SignaturePadController _padController = SignaturePadController();
  StreamSubscription<blueSerial.BluetoothDiscoveryResult> _streamSubscription;
  String _deviceName;

  @override
  void initState() {
    _searchBTDevice();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    PaymentController.stopSearchBTDevice();
    PaymentController.cancel();

    super.dispose();
  }

  Future<void> _captureEvent(String culprit, String errorMsg) async {
    if (App.application.config.env == 'development')
      return;

    User user = User.currentUser;
    App.application.sentry.client.capture(
      event: sentryLib.Event(
        culprit: culprit,
        exception: errorMsg,
        userContext: sentryLib.User(
          id: user.id.toString(),
          username: user.username,
          email: user.email
        ),
        environment: App.application.config.env,
        extra: {
          'osVersion': App.application.config.osVersion,
          'deviceModel': App.application.config.deviceModel,
          'orderNames': widget.debts.map((debt) => debt.orderName).join(', ')
        }
      )
    );
  }

  Future<String> _findBTDeviceNameIos() async {
    blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
    List<blue.ScanResult> results = await flutterBlue.startScan(timeout: _searchTimeout);
    blue.BluetoothDevice device = results.firstWhere(
      (blue.ScanResult result) => result?.device?.name?.contains('MPOS'),
      orElse: () => null
    )?.device;

    if (device == null) {
      return null;
    }

    return device.name;
  }

  Future<String> _findBTDeviceNameAndroid() async {
    blueSerial.FlutterBluetoothSerial bluetooth = blueSerial.FlutterBluetoothSerial.instance;
    List<blueSerial.BluetoothDevice> devices = await bluetooth.getBondedDevices();

    if (!devices.any((device) => device.name.contains('MPOS'))) {
      List<blueSerial.BluetoothDiscoveryResult> results = [];

      _streamSubscription = bluetooth.startDiscovery().listen((r) => results.add(r));
      await Future.delayed(_searchTimeout);
      _streamSubscription.cancel();

      devices.addAll(
        results
          .where((blueSerial.BluetoothDiscoveryResult result) => result.device != null)
          .map((result) => result.device)
      );
    }

    blueSerial.BluetoothDevice device = devices
      .where((device) => device.name != null)
      .firstWhere((device) => device.name.contains('MPOS'), orElse: () => null);

    if (device == null) {
      return null;
    }

    if (!device.isBonded) await bluetooth.bondDeviceAtAddress(device.address);

    return device.name;
  }

  Future<void> _searchBTDevice() async {
    if (!mounted) return;

    setState(() {
      _status = 'Установление связи с терминалом';
    });

    if (!(await blue.FlutterBlue.instance.isOn)) {
      Navigator.pop(context, {
        'success': false,
        'errorMessage': 'Не включен Bluetooth'
      });
      return;
    }

    try {
      _deviceName = await (Platform.isIOS ? _findBTDeviceNameIos() : _findBTDeviceNameAndroid());
    } catch(e) {
      _captureEvent('_searchBTDevice', e.toString());
      Navigator.pop(context, {
        'success': false,
        'errorMessage': 'Ошибка при установлении связи с терминалом'
      });
      return;
    }

    if (_deviceName == null) {
      Navigator.pop(context, {
        'success': false,
        'errorMessage': 'Не удалось найти терминал'
      });
      return;
    }

    await PaymentController.startSearchBTDevice(onReaderSetBTDevice: (res) async => await _getApiCredentials());
  }

  Future<void> _getApiCredentials() async {
    if (!mounted) return;

    setState(() {
      _status = 'Установление связи с сервером';
    });

    try {
      Map<String, dynamic> apiRes = await Api.get('v1/forwarder/credentials');

      _iboxLogin = apiRes['ibox_login'];
      _iboxPassword = apiRes['ibox_password'];

      await _apiLogin();
    } on ApiException catch(e) {
      Navigator.pop(context, {
        'success': false,
        'errorMessage': e.errorMsg
      });
    }
  }

  Future<void> _apiLogin() async {
    if (!mounted) return;

    setState(() {
      _status = 'Авторизация оплаты';
    });

    await PaymentController.login(
      email: _iboxLogin,
      password: _iboxPassword,
      onLogin: (res) async {
        int errorCode = res['errorCode'];

        if (errorCode == 0) {
          await _startPayment();
        } else {
          _captureEvent('apiLogin', errorCode.toString());
          Navigator.pop(context, {
            'success': false,
            'errorMessage': '$errorCode'
          });
        }
      }
    );
  }

  Future<void> _startPayment() async {
    if (!mounted) return;

    setState(() {
      _status = 'Ожидание ответа от терминала';
    });

    await PaymentController.startPayment(
      amount: widget.debts.map((debt) => debt.paymentSum).reduce((acc, el) => acc + el),
      description: 'Оплата за заказ ${widget.debts.map((debt) => debt.orderName).join(', ')}',
      inputType: InputType.NFC,
      singleStepAuth: true,
      onReaderEvent: (res) async {
        if (res['readerEventType'] == ReaderEventType.Disconnected) {
          Navigator.pop(context, {
            'success': false,
            'errorMessage': 'Прервана связь с терминалом'
          });
        }
      },
      onPaymentStart: (res) async {
        setState(() {
          _status = 'Обработка оплаты';
          _transactionId = res['id'];
          _showCancelButton = false;
        });
      },
      onPaymentError: (res) async {
        int errorType = res['errorType'];
        String errorMessage = res['errorMessage'];
        String errorFullMessage = '$errorType; $errorMessage';

        _captureEvent('startPaymentPaymentError', errorFullMessage);
        Navigator.pop(context, {
          'success': false,
          'errorMessage': errorFullMessage
        });
      },
      onPaymentComplete: (res) async {
        setState(() {
          _status = 'Подтверждение оплаты';
          _transaction = res['transaction'];
          _requiredSignature = res['requiredSignature'];
        });

        if (!_requiredSignature) {
          await _savePayment();
        } else {
          setState(() {
            _status = 'Для завершения оплаты\nнеобходимо указать подпись';
          });
        }
      }
    );
  }

  Future<void> _savePayment() async {
    setState(() {
      _status = 'Сохранение информации об оплате';
    });

    await PaymentController.info(
      trId: _transactionId,
      onInfo: (res) async {
        int errorCode = res['errorCode'];

        try {
          if (errorCode != 0) {
            _captureEvent('savePayment', errorCode.toString());
          }

          await Api.post('v1/forwarder/save', body: {
            'payments': widget.debts.map((debt) => {'id': debt.id, 'payment_sum': debt.paymentSum}).toList(),
            'payment_transaction': errorCode == 0 ? res : _transaction,
            'location': widget.location,
            'local_ts': DateTime.now().toIso8601String()
          });
          await App.application.data.dataSync.importData();
          Navigator.pop(context, {
            'success': true
          });
        } on ApiException catch(e) {
          Navigator.pop(context, {
            'success': false,
            'errorMessage': e.errorMsg
          });
        }
      }
    );
  }

  Future<void> _adjustPayment() async {
    setState(() {
      _requiredSignature = false;
      _status = 'Сохранение подписи клиента';
    });

    await PaymentController.adjustPayment(
      trId: _transactionId,
      signature: await _padController.toPng(),
      onPaymentAdjust: (res) async {
        int errorCode = res['errorCode'];

        if (errorCode == 0) {
          await _savePayment();
        } else {
          _captureEvent('adjustPayment', errorCode.toString());
          Navigator.pop(context, {
            'success': false,
            'errorMessage': '$errorCode'
          });
        }
      }
    );
  }

  List<Widget> _buildProgressPart() {
    return [
      CircularProgressIndicator(
        backgroundColor: Colors.white70,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      Container(height: 40),
      Text(_status, style: TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      Container(height: 40),
      Container(
        height: 32,
        child: _showCancelButton ? RaisedButton(
          child: Text('Отмена'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            Navigator.pop(context, {
              'success': false,
              'errorMessage': 'Отмена операции'
            });
          }
        ) : Container()
      ),
      Container(height: 40)
    ];
  }

  List<Widget> _buildInfoPart() {
    if (!_requiredSignature)
      return [Container(height: 272)];

    return [
      Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          border: Border.all(color: Colors.grey),
          color: Colors.white
        ),
        child: SignaturePadWidget(_padController, SignaturePadOptions(penColor: '#000000'))
      ),
      Container(height: 40),
      Container(
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Text('Очистить'),
              onPressed: () async {
                _padController.clear();
              }
            ),
            Container(width: 40),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Text('Подтвердить'),
              onPressed: () async {
                await _adjustPayment();
              }
            )
          ]
        )
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildProgressPart()..addAll(_buildInfoPart())
      )
    );
  }
}
