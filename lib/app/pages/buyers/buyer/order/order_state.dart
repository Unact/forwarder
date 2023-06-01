part of 'order_page.dart';

enum OrderStateStatus {
  initial,
  dataLoaded,
  needUserConfirmation,
  inProgress,
  success,
  failure,
  showScan,
  paymentStarted,
  paymentFailure,
  paymentFinished
}

class OrderState {
  OrderState({
    this.status = OrderStateStatus.initial,
    required this.order,
    required this.confirmationCallback,
    this.codeLines = const [],
    this.message = '',
    this.delivered = false,
    this.debt,
    this.isLink = false,
    this.isCard = false
  });

  final OrderStateStatus status;
  final Order order;
  final List<OrderLineWithCode> codeLines;
  final Function confirmationCallback;
  final String message;
  final bool delivered;
  final Debt? debt;
  final bool isLink;
  final bool isCard;

  bool get needPayment => debt != null && debt!.paymentSum != null && debt!.paidSum == 0;

  OrderState copyWith({
    OrderStateStatus? status,
    Order? order,
    List<OrderLineWithCode>? codeLines,
    Function? confirmationCallback,
    String? message,
    bool? delivered,
    Debt? debt,
    bool? isLink,
    bool? isCard
  }) {
    return OrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      debt: debt ?? this.debt,
      codeLines: codeLines ?? this.codeLines,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      message: message ?? this.message,
      delivered: delivered ?? this.delivered,
      isLink: isLink ?? this.isLink,
      isCard: isCard ?? this.isCard
    );
  }
}
