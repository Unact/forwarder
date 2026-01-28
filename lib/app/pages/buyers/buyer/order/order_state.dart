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
  paymentFinished,
  orderDataCopied
}

class OrderState {
  OrderState({
    this.status = OrderStateStatus.initial,
    required this.order,
    required this.confirmationCallback,
    this.codeLines = const [],
    this.message = '',
    this.delivered = false,
    this.debts = const []
  });

  final OrderStateStatus status;
  final Order order;
  final List<OrderLineWithCode> codeLines;
  final Function confirmationCallback;
  final String message;
  final bool delivered;
  final List<Debt> debts;

  bool get needPayment => debts.isNotEmpty &&
    debts.every((e) => e.paymentSum != null) &&
    debts.every((e) => e.paidSum == 0);
  double get totalSum => codeLines.map((e) => e.orderLine.vol * e.orderLine.price).fold<double>(0, (sum, e) => sum + e);
  double get scannedSum => codeLines
    .map((e) => e.orderLineCodes.fold<double>(0, (sum, ei) => sum + ei.amount) * e.orderLine.price)
    .fold<double>(0, (sum, e) => sum + e);

  OrderState copyWith({
    OrderStateStatus? status,
    Order? order,
    List<OrderLineWithCode>? codeLines,
    Function? confirmationCallback,
    String? message,
    bool? delivered,
    List<Debt>? debts
  }) {
    return OrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      debts: debts ?? this.debts,
      codeLines: codeLines ?? this.codeLines,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      message: message ?? this.message,
      delivered: delivered ?? this.delivered
    );
  }
}
