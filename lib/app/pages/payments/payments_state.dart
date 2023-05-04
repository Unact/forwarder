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
    this.cardPayments = const [],
    this.buyers = const [],
    this.message = '',
    this.cardPaymentToCancel
  });

  final PaymentsStateStatus status;
  final String message;

  final List<CashPayment> cashPayments;
  final List<CardPayment> cardPayments;
  final List<Buyer> buyers;

  final CardPayment? cardPaymentToCancel;

  PaymentsState copyWith({
    PaymentsStateStatus? status,
    List<CashPayment>? cashPayments,
    List<CardPayment>? cardPayments,
    List<Buyer>? buyers,
    String? message,
    CardPayment? cardPaymentToCancel
  }) {
    return PaymentsState(
      status: status ?? this.status,
      message: message ?? this.message,
      cashPayments: cashPayments ?? this.cashPayments,
      cardPayments: cardPayments ?? this.cardPayments,
      buyers: buyers ?? this.buyers,
      cardPaymentToCancel: cardPaymentToCancel ?? this.cardPaymentToCancel
    );
  }
}
