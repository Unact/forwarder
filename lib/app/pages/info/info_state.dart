part of 'info_page.dart';

enum InfoStateStatus {
  initial,
  startLoad,
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
    this.cardPayments = const [],
    this.cashPayments = const []
  });

  final InfoStateStatus status;
  final List<CardPayment> cardPayments;
  final List<CashPayment> cashPayments;
  final String message;
  final User? user;
  final AppInfoResult? appInfo;

  int get buyersCnt => appInfo?.buyersTotal ?? 0;
  int get ordersCnt => appInfo?.ordersTotal ?? 0;
  int get incCnt => appInfo?.incOrdersTotal ?? 0;

  bool get closed => user?.closed ?? false;
  double get total => user?.total ?? 0;

  double get cardPaymentsSum => cardPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => cashPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get paymentsSum => cardPaymentsSum + cashPaymentsSum - cardPaymentsCancelSum;
  double get kkmSum => cashPayments.where((payment) => payment.kkmprinted)
    .fold(0, (sum, payment) => sum + payment.summ);
  double get cardPaymentsCancelSum => cardPayments.where((payment) => payment.canceled)
    .fold(0, (sum, payment) => sum + payment.summ);

  InfoState copyWith({
    InfoStateStatus? status,
    String? message,
    User? user,
    AppInfoResult? appInfo,
    List<CardPayment>? cardPayments,
    List<CashPayment>? cashPayments
  }) {
    return InfoState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      appInfo: appInfo ?? this.appInfo,
      cardPayments: cardPayments ?? this.cardPayments,
      cashPayments: cashPayments ?? this.cashPayments,
    );
  }
}
