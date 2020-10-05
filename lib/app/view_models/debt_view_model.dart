import 'package:flutter/material.dart';
import 'package:forwarder/app/utils/format.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

enum DebtState {
  Initial,
  NeedUserConfirmation,
  PaymentStarted,
  PaymentFinished,
  PaymentFailure,
  PaymentSumChanged
}

class DebtViewModel extends BaseViewModel {
  Debt debt;
  DebtState _state = DebtState.Initial;
  String _message;
  Function _confirmationCallback;
  bool _isCard = false;

  DebtViewModel({@required BuildContext context, @required this.debt}) : super(context: context);

  DebtState get state => _state;
  String get message => _message;
  Function get confirmationCallback => _confirmationCallback;
  bool get isCard => _isCard;

  bool get isEditable => debt.debtSum > 0;

  void updatePaymentSum(double newValue) {
    Debt updatedDebt = Debt(
      id: debt.id,
      buyerId: debt.buyerId,
      orderId: debt.orderId,
      ndoc: debt.ndoc,
      orderNdoc: debt.orderNdoc,
      ddate: debt.ddate,
      orderDdate: debt.ddate,
      isCheck: debt.isCheck,
      debtSum: debt.debtSum,
      orderSum: debt.orderSum,
      paidSum: debt.paidSum,
      paymentSum: newValue
    );

    debt = updatedDebt;

    _setState(DebtState.PaymentSumChanged);
  }

  void tryStartPayment(bool isCard) {
    if (debt.paymentSum == null) {
      _setMessage('Указана некорректная сумма');
      _setState(DebtState.PaymentFailure);

      return;
    }

    _isCard = isCard;
    _message = 'Вы уверены, что хотите внести оплату ${Format.numberStr(debt.paymentSum)} руб.?\n' +
      'Изменить потом будет нельзя.';
    _confirmationCallback = startPayment;
    _setState(DebtState.NeedUserConfirmation);
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    _setState(DebtState.PaymentStarted);
  }

  void finishPayment(Map<String, dynamic> result) {
    debt = Debt(
      id: debt.id,
      buyerId: debt.buyerId,
      orderId: debt.orderId,
      ndoc: debt.ndoc,
      orderNdoc: debt.orderNdoc,
      ddate: debt.ddate,
      orderDdate: debt.ddate,
      isCheck: debt.isCheck,
      debtSum: debt.debtSum,
      orderSum: debt.orderSum,
      paidSum: debt.paidSum + debt.paymentSum,
      paymentSum: null
    );

    _setMessage(result['message']);
    _setState(DebtState.PaymentFinished);
  }

  void _setState(DebtState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
