part of 'info_page.dart';

enum InfoStateStatus {
  initial,
  dataLoaded,
  reverseInProgress,
  reverseSuccess,
  reverseFailure
}

class InfoState {
  InfoState({
    this.status = InfoStateStatus.initial,
    this.message = '',
    this.user,
    this.appInfo,
    this.cashPayments = const [],
    this.deliveries = const []
  });

  final InfoStateStatus status;
  final List<CashPayment> cashPayments;
  final List<Delivery> deliveries;
  final String message;
  final User? user;
  final AppInfoResult? appInfo;

  int get buyersCnt => appInfo?.buyersTotal ?? 0;
  int get ordersCnt => appInfo?.ordersTotal ?? 0;
  int get incCnt => appInfo?.incOrdersTotal ?? 0;

  bool get closed => user?.closed ?? false;
  double get total => user?.total ?? 0;

  double get cashPaymentsSum => cashPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get paymentsSum => cashPaymentsSum;
  double get kkmSum => cashPayments.where((payment) => payment.kkmprinted)
    .fold(0, (sum, payment) => sum + payment.summ);

  InfoState copyWith({
    InfoStateStatus? status,
    String? message,
    User? user,
    AppInfoResult? appInfo,
    List<CashPayment>? cashPayments,
    List<Delivery>? deliveries
  }) {
    return InfoState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      appInfo: appInfo ?? this.appInfo,
      cashPayments: cashPayments ?? this.cashPayments,
      deliveries: deliveries ?? this.deliveries
    );
  }
}
