part of 'buyers_page.dart';

enum BuyersStateStatus {
  initial,
  dataLoaded
}

class BuyersState {
  BuyersState({
    this.status = BuyersStateStatus.initial,
    this.orders = const [],
    this.buyers = const []
  });

  final BuyersStateStatus status;
  final List<Order> orders;
  final List<BuyerEx> buyers;

  BuyersState copyWith({
    BuyersStateStatus? status,
    List<Order>? orders,
    List<BuyerEx>? buyers
  }) {
    return BuyersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      buyers: buyers ?? this.buyers
    );
  }
}
