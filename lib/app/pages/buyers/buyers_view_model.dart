part of 'buyers_page.dart';

class BuyersViewModel extends PageViewModel<BuyersState, BuyersStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<BuyerEx>>? buyersSubscription;
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

  List<Order> buyerOrders(BuyerEx buyer) => state.orders
    .where((e) => e.buyerId == buyer.buyer.buyerId && e.deliveryId == buyer.buyer.deliveryId).toList();
  List<BuyerEx> notFinishedBuyers(int deliveryId) => state.buyers
    .where((e) => e.buyer.deliveryId == deliveryId)
    .where((e) => !e.missed && !e.departed).toList();
  List<BuyerEx> finishedBuyers(int deliveryId) => state.buyers
    .where((e) => e.buyer.deliveryId == deliveryId)
    .where((e) => e.missed || e.departed).toList();
}
