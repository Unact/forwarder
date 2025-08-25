part of 'payments_page.dart';

enum PaymentsStateStatus {
  initial,
  dataLoaded,
  cancelStarted,
  cancelFinished
}

class PaymentsState {
  PaymentsState({
    this.status = PaymentsStateStatus.initial,
    this.cashPayments = const [],
    this.buyers = const [],
    this.message = ''
  });

  final PaymentsStateStatus status;
  final String message;

  final List<CashPayment> cashPayments;
  final List<BuyerEx> buyers;

  PaymentsState copyWith({
    PaymentsStateStatus? status,
    List<CashPayment>? cashPayments,
    List<BuyerEx>? buyers,
    String? message
  }) {
    return PaymentsState(
      status: status ?? this.status,
      message: message ?? this.message,
      cashPayments: cashPayments ?? this.cashPayments,
      buyers: buyers ?? this.buyers
    );
  }
}
