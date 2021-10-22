import 'package:flutter/material.dart';
import 'package:forwarder/app/utils/format.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

enum BuyerState {
  Initial,
  NeedUserConfirmation,
  DebtChanged,
  PaymentStarted,
  PaymentFinished
}

class BuyerViewModel extends BaseViewModel {
  final Buyer buyer;
  final bool isInc;
  BuyerState _state = BuyerState.Initial;
  String? _message;
  List<Debt> _debtsToPay = [];
  bool _isCard = false;
  Function? _confirmationCallback;

  BuyerViewModel({
    required BuildContext context,
    required this.buyer,
    required this.isInc
  }) : super(context: context);

  BuyerState get state => _state;
  String? get message => _message;
  List<Debt> get debtsToPay => _debtsToPay;
  bool get isCard => _isCard;
  Function? get confirmationCallback => _confirmationCallback;

  List<Order> get orders => appState.orders.where((e) => e.buyerId == buyer.id).toList()
    ..sort((order1, order2) => order1.ndoc.compareTo(order2.ndoc));
  List<Debt> get debts => appState.debts.where((e) => e.buyerId == buyer.id).toList()
    ..sort((debt1, debt2) => debt1.fullname.compareTo(debt2.fullname));
  List<CardPayment> get cardPayments => appState.cardPayments.where((e) => e.buyerId == buyer.id).toList();
  List<CashPayment> get cashPayments => appState.cashPayments.where((e) => e.buyerId == buyer.id).toList();

  double get debtsSum => debts.fold(0, (sum, debt) => sum + debt.debtSum);
  double get kkmSum => cashPayments.where((e) => e.isKkmprinted).fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => cashPayments.fold(0, (sum, debt) => sum + debt.summ);
  double get cardPaymentsSum => cardPayments.fold(0, (sum, debt) => sum + debt.summ);

  bool get isPayable => debts.any((e) => e.paymentSum != null);

  Future<void> updateDebtPaymentSum(Debt debt, double? newValue) async {
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

    await appState.updateDebt(updatedDebt);

    _setState(BuyerState.DebtChanged);
  }

  bool debtIsEditable(Debt debt) => debt.debtSum > 0;

  void tryStartPayment(bool isCard) {
    List<Debt> debtsToPay = debts.where((e) => e.paymentSum != null).toList();
    double paymentSumTotal = debtsToPay.fold(0, (sum, e) => sum + e.paymentSum!);
    _debtsToPay = debtsToPay;
    _isCard = isCard;
    _message = 'Вы уверены, что хотите внести оплату ${Format.numberStr(paymentSumTotal)} руб.?\n' +
      'Изменить потом будет нельзя.';
    _confirmationCallback = startPayment;
    _setState(BuyerState.NeedUserConfirmation);
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    _setState(BuyerState.PaymentStarted);
  }

  void finishPayment(AcceptPaymentResult result) {
    _setMessage(result.message);
    _setState(BuyerState.PaymentFinished);
  }

  void _setState(BuyerState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
  }
}
