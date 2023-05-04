part of 'buyer_page.dart';

enum BuyerStateStatus {
  initial,
  dataLoaded,
  needUserConfirmation,
  debtChanged,
  paymentStarted,
  paymentFinished
}

class BuyerState {
  BuyerState({
    this.status = BuyerStateStatus.initial,
    required this.buyer,
    required this.isInc,
    this.cardPayments = const [],
    this.cashPayments = const [],
    this.orders = const [],
    this.debts = const [],
    required this.confirmationCallback,
    this.isCard = false,
    this.debtsToPay = const [],
    this.message = ''
  });

  final BuyerStateStatus status;
  final Buyer buyer;
  final bool isInc;
  final List<CardPayment> cardPayments;
  final List<CashPayment> cashPayments;
  final List<Order> orders;
  final List<Debt> debts;
  final Function confirmationCallback;
  final bool isCard;
  final List<Debt> debtsToPay;
  final String message;

  double get debtsSum => debts.fold(0, (sum, debt) => sum + debt.debtSum);
  double get kkmSum => cashPayments.where((e) => e.kkmprinted).fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => cashPayments.fold(0, (sum, debt) => sum + debt.summ);
  double get cardPaymentsSum => cardPayments.fold(0, (sum, debt) => sum + debt.summ);
  bool get isPayable => debts.any((e) => e.paymentSum != null && e.debtSum != 0);

  BuyerState copyWith({
    BuyerStateStatus? status,
    Buyer? buyer,
    bool? isInc,
    List<CardPayment>? cardPayments,
    List<CashPayment>? cashPayments,
    List<Order>? orders,
    List<Debt>? debts,
    Function? confirmationCallback,
    bool? isCard,
    List<Debt>? debtsToPay,
    String? message
  }) {
    return BuyerState(
      status: status ?? this.status,
      buyer: buyer ?? this.buyer,
      isInc: isInc ?? this.isInc,
      cardPayments: cardPayments ?? this.cardPayments,
      cashPayments: cashPayments ?? this.cashPayments,
      orders: orders ?? this.orders,
      debts: debts ?? this.debts,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      isCard: isCard ?? this.isCard,
      debtsToPay: debtsToPay ?? this.debtsToPay,
      message: message ?? this.message
    );
  }
}
