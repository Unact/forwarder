part of 'buyers_page.dart';

class BuyersViewModel extends PageViewModel<BuyersState, BuyersStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<Buyer>>? buyersSubscription;
  StreamSubscription<List<Order>>? ordersSubscription;

  BuyersViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository) : super(BuyersState());

  @override
  BuyersStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    buyersSubscription = ordersRepository.watchBuyers().listen((event) {
      emit(state.copyWith(status: BuyersStateStatus.dataLoaded, buyers: event));
    });
    ordersSubscription = ordersRepository.watchOrders().listen((event) {
      emit(state.copyWith(status: BuyersStateStatus.dataLoaded, orders: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await buyersSubscription?.cancel();
    await ordersSubscription?.cancel();
  }

  List<Order> buyerOrders(Buyer buyer) => state.orders
    .where((e) => e.buyerId == buyer.buyerId && e.deliveryId == buyer.deliveryId).toList();
  List<Buyer> notFinishedBuyers(int deliveryId) => state.buyers
    .where((e) => e.deliveryId == deliveryId)
    .where((e) => e.missedTs == null && e.departureTs == null).toList();
  List<Buyer> finishedBuyers(int deliveryId) => state.buyers
    .where((e) => e.deliveryId == deliveryId)
    .where((e) => e.missedTs != null || e.departureTs != null).toList();
}
