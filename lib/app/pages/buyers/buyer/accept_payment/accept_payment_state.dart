part of 'accept_payment_page.dart';

enum AcceptPaymentStateStatus {
  initial,
  dataLoaded,
  searchingForDevice,
  gettingCredentials,
  paymentAuthorization,
  waitingForPayment,
  waitingForExternalPayment,
  paymentStarted,
  paymentFinished,
  requiredSignature,
  savingSignature,
  savingPayment,
  finished,
  failure
}

class AcceptPaymentState {
  AcceptPaymentState({
    this.status = AcceptPaymentStateStatus.initial,
    required this.debts,
    this.orders = const [],
    this.position,
    this.message = ''
  });

  final List<Order> orders;
  final List<Debt> debts;
  final Position? position;
  final String message;
  final AcceptPaymentStateStatus status;

  AcceptPaymentState copyWith({
    AcceptPaymentStateStatus? status,
    List<Debt>? debts,
    List<Order>? orders,
    Position? position,
    String? message
  }) {
    return AcceptPaymentState(
      status: status ?? this.status,
      debts: debts ?? this.debts,
      orders: orders ?? this.orders,
      position: position ?? this.position,
      message: message ?? this.message,
    );
  }
}
