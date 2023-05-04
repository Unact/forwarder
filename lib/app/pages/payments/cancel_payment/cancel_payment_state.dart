part of 'cancel_payment_page.dart';

enum CancelPaymentStateStatus {
  initial,
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

class CancelPaymentState {
  CancelPaymentState({
    this.status = CancelPaymentStateStatus.initial,
    required this.cardPayment,
    this.canceled = false,
    this.isCancelable = true,
    this.isRequiredSignature = false,
    this.message = ''
  });

  final CardPayment cardPayment;
  final String message;
  final CancelPaymentStateStatus status;
  final bool canceled;
  final bool isCancelable;
  final bool isRequiredSignature;

  CancelPaymentState copyWith({
    CancelPaymentStateStatus? status,
    CardPayment? cardPayment,
    bool? canceled,
    bool? isCancelable,
    bool? isRequiredSignature,
    String? message
  }) {
    return CancelPaymentState(
      status: status ?? this.status,
      cardPayment: cardPayment ?? this.cardPayment,
      canceled: canceled ?? this.canceled,
      isCancelable: isCancelable ?? this.isCancelable,
      isRequiredSignature: isRequiredSignature ?? this.isRequiredSignature,
      message: message ?? this.message
    );
  }
}
