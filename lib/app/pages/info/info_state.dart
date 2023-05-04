part of 'info_page.dart';

enum InfoStateStatus {
  initial,
  startLoad,
  dataLoaded,
  success,
  failure,
  inProgress,
  reverseInProgress,
  reverseSuccess,
  reverseFailure
}

class InfoState {
  InfoState({
    this.status = InfoStateStatus.initial,
    this.newVersionAvailable = false,
    this.message = '',
    this.user,
    this.pref,
    this.buyers = const [],
    this.orders = const [],
    this.cardPayments = const [],
    this.cashPayments = const []
  });

  final InfoStateStatus status;
  final List<Buyer> buyers;
  final List<Order> orders;
  final List<CardPayment> cardPayments;
  final List<CashPayment> cashPayments;
  final bool newVersionAvailable;
  final String message;
  final User? user;
  final Pref? pref;

  int get buyersCnt => buyers.length;
  int get ordersCnt => orders.length;

  bool get closed => user?.closed ?? false;
  double get total => user?.total ?? 0;
  String get salesmanNum => user?.salesmanNum ?? 'Не удалось опредилить';


  bool get isBusy => [
    InfoStateStatus.inProgress,
    InfoStateStatus.reverseInProgress
  ].contains(status);

  int get incCnt => orders.where((order) => order.isInc).length +
    buyers.where((buyer) => !orders.any((order) => order.buyerId == buyer.id)).length;
  double get cardPaymentsSum => cardPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get cashPaymentsSum => cashPayments.fold(0, (sum, payment) => sum + payment.summ);
  double get paymentsSum => cardPaymentsSum + cashPaymentsSum - cardPaymentsCancelSum;
  double get kkmSum => cashPayments.where((payment) => payment.kkmprinted)
    .fold(0, (sum, payment) => sum + payment.summ);
  double get cardPaymentsCancelSum => cardPayments.where((payment) => payment.canceled)
    .fold(0, (sum, payment) => sum + payment.summ);

  InfoState copyWith({
    InfoStateStatus? status,
    bool? newVersionAvailable,
    String? message,
    User? user,
    Pref? pref,
    List<Buyer>? buyers,
    List<Order>? orders,
    List<CardPayment>? cardPayments,
    List<CashPayment>? cashPayments
  }) {
    return InfoState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      pref: pref ?? this.pref,
      buyers: buyers ?? this.buyers,
      orders: orders ?? this.orders,
      cardPayments: cardPayments ?? this.cardPayments,
      cashPayments: cashPayments ?? this.cashPayments,
    );
  }
}
