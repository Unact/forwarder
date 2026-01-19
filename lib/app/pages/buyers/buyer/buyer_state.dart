part of 'buyer_page.dart';

enum BuyerStateStatus {
  initial,
  dataLoaded,
  needUserConfirmation,
  debtChanged,
  paymentStarted,
  paymentFinished,
  inProgress,
  failure,
  success,
  coordsCopied,
  deliveryPointOpened
}

class BuyerState {
  BuyerState({
    this.status = BuyerStateStatus.initial,
    required this.buyer,
    this.cashPayments = const [],
    this.orders = const [],
    this.debts = const [],
    this.tasks = const [],
    required this.confirmationCallback,
    this.debtsToPay = const [],
    this.message = '',
    this.pointEx,
    this.taskToFinish,
    this.completed = false,
  });

  final BuyerStateStatus status;
  final BuyerEx buyer;
  final List<CashPayment> cashPayments;
  final List<Order> orders;
  final List<Debt> debts;
  final List<Task> tasks;
  final Function confirmationCallback;
  final List<Debt> debtsToPay;
  final Task? taskToFinish;
  final String message;
  final BuyerDeliveryPointEx? pointEx;
  final bool completed;

  double get debtsSum => debts.fold(0, (sum, debt) => sum + debt.debtSum);
  double get kkmSum => cashPayments.where((e) => e.kkmprinted).fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => cashPayments.fold(0, (sum, debt) => sum + debt.summ);
  bool get isPayable => debts.any((e) => e.paymentSum != null && e.debtSum != 0);

  BuyerState copyWith({
    BuyerStateStatus? status,
    BuyerEx? buyer,
    List<CashPayment>? cashPayments,
    List<Order>? orders,
    List<Debt>? debts,
    List<Task>? tasks,
    Function? confirmationCallback,
    List<Debt>? debtsToPay,
    String? message,
    BuyerDeliveryPointEx? pointEx,
    ({ Task? value })? taskToFinish,
    bool? completed
  }) {
    return BuyerState(
      status: status ?? this.status,
      buyer: buyer ?? this.buyer,
      cashPayments: cashPayments ?? this.cashPayments,
      orders: orders ?? this.orders,
      debts: debts ?? this.debts,
      tasks: tasks ?? this.tasks,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      debtsToPay: debtsToPay ?? this.debtsToPay,
      message: message ?? this.message,
      pointEx: pointEx ?? this.pointEx,
      taskToFinish: taskToFinish != null ? taskToFinish.value : this.taskToFinish,
      completed: completed ?? this.completed
    );
  }
}
