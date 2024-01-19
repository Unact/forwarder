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
    required this.isCard,
    required this.isLink,
    this.orders = const [],
    this.position,
    this.canceled = false,
    this.isCancelable = true,
    this.isRequiredSignature = false,
    this.message = '',
    this.externalPaymentQR = '',
    this.paymentChecked = 0
  });

  final List<Order> orders;
  final List<Debt> debts;
  final bool isCard;
  final bool isLink;
  final Position? position;
  final String message;
  final String externalPaymentQR;
  final AcceptPaymentStateStatus status;
  final bool canceled;
  final bool isCancelable;
  final bool isRequiredSignature;
  final int paymentChecked;

  AcceptPaymentState copyWith({
    AcceptPaymentStateStatus? status,
    List<Debt>? debts,
    bool? isCard,
    bool? isLink,
    List<Order>? orders,
    Position? position,
    bool? canceled,
    bool? isCancelable,
    bool? isRequiredSignature,
    String? message,
    String? externalPaymentQR,
    int? paymentChecked
  }) {
    return AcceptPaymentState(
      status: status ?? this.status,
      debts: debts ?? this.debts,
      isCard: isCard ?? this.isCard,
      isLink: isLink ?? this.isLink,
      orders: orders ?? this.orders,
      position: position ?? this.position,
      canceled: canceled ?? this.canceled,
      isCancelable: isCancelable ?? this.isCancelable,
      isRequiredSignature: isRequiredSignature ?? this.isRequiredSignature,
      message: message ?? this.message,
      externalPaymentQR: externalPaymentQR ?? this.externalPaymentQR,
      paymentChecked: paymentChecked ?? this.paymentChecked
    );
  }
}
