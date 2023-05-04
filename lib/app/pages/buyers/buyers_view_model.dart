part of 'buyers_page.dart';

class BuyersViewModel extends PageViewModel<BuyersState, BuyersStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;

  BuyersViewModel(this.appRepository, this.ordersRepository) : super(BuyersState(), [appRepository, ordersRepository]);

  @override
  BuyersStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: BuyersStateStatus.dataLoaded,
      buyers: await ordersRepository.getBuyers(),
      orders: await ordersRepository.getOrders()
    ));
  }

  List<Order> buyerOrders(Buyer buyer) => state.orders.where((e) => e.buyerId == buyer.id).toList();
  List<Buyer> get buyersWithoutDel =>
    state.buyers.where((e) => buyerOrders(e).any((e) => !e.didDelivery)).toList();
  List<Buyer> get buyersWithDel =>
    state.buyers.where((e) => buyerOrders(e).every((e) => e.didDelivery)).toList();
  bool buyerIsInc(Buyer b) => state.orders.any((e) => e.buyerId == b.id && e.isInc) || buyerOrders(b).isEmpty;
}
