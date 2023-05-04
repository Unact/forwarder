part of 'order_page.dart';

enum OrderStateStatus {
  initial,
  dataLoaded,
  needUserConfirmation,
  inProgress,
  success,
  failure
}

class OrderState {
  OrderState({
    this.status = OrderStateStatus.initial,
    required this.order,
    required this.confirmationCallback,
    this.message = '',
    this.delivered = false
  });

  final OrderStateStatus status;
  final Order order;
  final Function confirmationCallback;
  final String message;
  final bool delivered;

  OrderState copyWith({
    OrderStateStatus? status,
    Order? order,
    Function? confirmationCallback,
    String? message,
    bool? delivered
  }) {
    return OrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      message: message ?? this.message,
      delivered: delivered ?? this.delivered
    );
  }
}
