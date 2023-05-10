part of 'accept_payment_page.dart';

enum AcceptPaymentStateStatus {
  initial,
  dataLoaded,
  searchingForDevice,
  gettingCredentials,
  paymentAuthorization,
  waitingForPayment,
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
    required this.isCard,
    this.orders = const [],
    this.location,
    this.canceled = false,
    this.isCancelable = true,
    this.isRequiredSignature = false,
    this.message = ''
  });

  final List<Order> orders;
  final List<Debt> debts;
  final bool isCard;
  final Location? location;
  final String message;
  final AcceptPaymentStateStatus status;
  final bool canceled;
  final bool isCancelable;
  final bool isRequiredSignature;

  AcceptPaymentState copyWith({
    AcceptPaymentStateStatus? status,
    List<Debt>? debts,
    bool? isCard,
    List<Order>? orders,
    Location? location,
    bool? canceled,
    bool? isCancelable,
    bool? isRequiredSignature,
    String? message
  }) {
    return AcceptPaymentState(
      status: status ?? this.status,
      debts: debts ?? this.debts,
      isCard: isCard ?? this.isCard,
      orders: orders ?? this.orders,
      location: location ?? this.location,
      canceled: canceled ?? this.canceled,
      isCancelable: isCancelable ?? this.isCancelable,
      isRequiredSignature: isRequiredSignature ?? this.isRequiredSignature,
      message: message ?? this.message
    );
  }
}
