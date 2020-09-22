import 'package:flutter/material.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

enum PaymentsState {
  Initial,
  CancelStarted,
  CancelFinished
}

class PaymentsViewModel extends BaseViewModel {
  PaymentsState _state = PaymentsState.Initial;
  String _message;
  CardPayment _cardPaymentToCancel;

  PaymentsViewModel({@required BuildContext context}) : super(context: context);

  PaymentsState get state => _state;
  String get message => _message;
  CardPayment get cardPaymentToCancel => _cardPaymentToCancel;

  List<CardPayment> get cardPayments => appState.cardPayments;
  List<CashPayment> get cashPayments => appState.cashPayments;

  Buyer buyerForCardPayment(CardPayment cardPayment) => appState.buyers.firstWhere((e) => e.id == cardPayment.buyerId);
  Buyer buyerForCashPayment(CashPayment cashPayment) => appState.buyers.firstWhere((e) => e.id == cashPayment.buyerId);

  void startCancelPayment(CardPayment cardPayment) {
    _cardPaymentToCancel = cardPayment;
    _setState(PaymentsState.CancelStarted);
  }

  void finishCancelPayment(Map<String, dynamic> result) {
    _setMessage(result['message']);
    _setState(PaymentsState.CancelFinished);
  }

  void _setState(PaymentsState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
