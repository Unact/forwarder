part of 'payments_page.dart';

class PaymentsViewModel extends PageViewModel<PaymentsState, PaymentsStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<BuyerEx>>? buyersSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;
  PaymentsViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository) : super(PaymentsState());

  @override
  PaymentsStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    buyersSubscription = ordersRepository.watchBuyers().listen((event) {
      emit(state.copyWith(status: PaymentsStateStatus.dataLoaded, buyers: event));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPayments().listen((event) {
      emit(state.copyWith(status: PaymentsStateStatus.dataLoaded, cashPayments: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await buyersSubscription?.cancel();
    await cashPaymentsSubscription?.cancel();
  }

  List<CashPayment> get cashPayments => state.cashPayments..sort((cashPayment1, cashPayment2) {
    Buyer buyer1 = buyerForCashPayment(cashPayment1);
    Buyer buyer2 = buyerForCashPayment(cashPayment2);
    int ordCompare = buyer1.name.toLowerCase().compareTo(buyer2.name.toLowerCase());

    return ordCompare == 0 ? cashPayment1.summ.compareTo(cashPayment2.summ) : ordCompare;
  });

  Buyer buyerForCashPayment(CashPayment cp) => state.buyers.firstWhere((e) => e.buyer.buyerId == cp.buyerId).buyer;
}
