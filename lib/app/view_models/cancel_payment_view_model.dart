import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:forwarder/app/app_state.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/iboxpro.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

enum CancelPaymentState {
  Initial,
  SearchingForDevice,
  GettingCredentials,
  PaymentAuthorization,
  WaitingForPayment,
  PaymentStarted,
  PaymentFinished,
  RequiredSignature,
  SavingSignature,
  SavingPayment,
  Finished,
  Failure,
  Disconnected
}

class CancelPaymentViewModel extends BaseViewModel {
  CardPayment cardPayment;
  String _message = 'Инициализация отмены';
  CancelPaymentState _state = CancelPaymentState.Initial;
  bool _canceled = false;
  bool _isCancelable = false;
  bool _requiredSignature = false;
  Iboxpro iboxpro = Iboxpro();

  CancelPaymentViewModel({
    required BuildContext context,
    required this.cardPayment
  }) : super(context: context) {
    _connectToDevice();
  }

  CancelPaymentState get state => _state;
  String get message => _message;

  bool get requiredSignature => _requiredSignature;
  bool get isCancelable => _isCancelable;

  Future<void> cancelPayment() async {
    _canceled = true;
    await iboxpro.cancelPayment();

    _setMessage('Платеж отменен');
    _setState(CancelPaymentState.Failure);
  }

  Future<void> _connectToDevice() async {
    _isCancelable = true;
    _setMessage('Установление связи с терминалом');
    _setState(CancelPaymentState.SearchingForDevice);

    iboxpro.connectToDevice(
      onError: (String error) {
        _setMessage(error);
        _setState(CancelPaymentState.Failure);
      },
      onConnected: _getPaymentCredentials
    );
  }

  Future<void> _getPaymentCredentials() async {
    if (_canceled) return;

    _setMessage('Установление связи с сервером');
    _setState(CancelPaymentState.GettingCredentials);

    try {
      PaymentCredentials credentials = await appState.getPaymentCredentials();

      await _apiLogin(credentials.login, credentials.password);
    } on AppError catch(e) {
      _setMessage(e.message);
      _setState(CancelPaymentState.Failure);
    }
  }

  Future<void> _apiLogin(String login, String password) async {
    if (_canceled) return;

    _setMessage('Авторизация оплаты');
    _setState(CancelPaymentState.PaymentAuthorization);

    await iboxpro.apiLogin(
      login: login,
      password: password,
      onError: (String error) {
        _setMessage(error);
        _setState(CancelPaymentState.Failure);
      },
      onLogin: _startReversePayment
    );
  }

  Future<void> _startReversePayment() async {
    if (_canceled) return;

    _setMessage('Ожидание ответа от терминала');
    _setState(CancelPaymentState.WaitingForPayment);

    await iboxpro.startReversePayment(
      id: cardPayment.transactionId!,
      amount: cardPayment.summ,
      description: 'Отмена заказа',
      onError: (String error) {
        _setMessage(error);
        _setState(CancelPaymentState.Failure);
      },
      onDisconnect: () {
        _setMessage('Прервана связь с терминалом');
        _setState(CancelPaymentState.Disconnected);
      },
      onPaymentStart: (_) {
        _isCancelable = false;
        _setMessage('Обработка отмены');
        _setState(CancelPaymentState.PaymentStarted);
      },
      onPaymentComplete: (Map<String, dynamic> transaction, bool requiredSignature) {
        _requiredSignature = requiredSignature;
        _setMessage('Подтверждение отмены');
        _setState(CancelPaymentState.PaymentFinished);

        if (!_requiredSignature) {
          _savePayment(transaction);
        } else {
          _setMessage('Для завершения отмены\nнеобходимо указать подпись');
          _setState(CancelPaymentState.RequiredSignature);
        }
      }
    );
  }

  Future<void> adjustReversePayment(Uint8List signature) async {
    _requiredSignature = false;
    _setMessage('Сохранение подписи клиента');
    _setState(CancelPaymentState.SavingSignature);

    await iboxpro.adjustReversePayment(
      signature: signature,
      onError: (String error) {
        _setMessage(error);
        _setState(CancelPaymentState.Failure);
      },
      onReversePaymentAdjust: _savePayment
    );
  }

  Future<void> _savePayment(Map<String, dynamic> transaction) async {
    _setMessage('Сохранение информации об отмене');
    _setState(CancelPaymentState.SavingPayment);

    try {
      cardPayment = await appState.cancelCardPayment(cardPayment, transaction);

      _setMessage('Отмена успешно сохранена');
      _setState(CancelPaymentState.Finished);
    } on AppError catch(e) {
      _setMessage('Ошибка при сохранении отмены ${e.message}');
      _setState(CancelPaymentState.Failure);
    }
  }

  void _setState(CancelPaymentState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
