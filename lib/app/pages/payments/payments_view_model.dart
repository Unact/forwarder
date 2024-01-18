part of 'payments_page.dart';

class PaymentsViewModel extends PageViewModel<PaymentsState, PaymentsStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<Buyer>>? buyersSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;
  StreamSubscription<List<CardPayment>>? cardPaymentsSubscription;

  PaymentsViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository) : super(PaymentsState());

  @override
  PaymentsStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    buyersSubscription = ordersRepository.watchBuyers().listen((event) {
      emit(state.copyWith(status: PaymentsStateStatus.dataLoaded, buyers: event));
    });
    cardPaymentsSubscription = paymentsRepository.watchCardPayments().listen((event) {
      emit(state.copyWith(status: PaymentsStateStatus.dataLoaded, cardPayments: event));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPayments().listen((event) {
      emit(state.copyWith(status: PaymentsStateStatus.dataLoaded, cashPayments: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await buyersSubscription?.cancel();
    await cardPaymentsSubscription?.cancel();
    await cashPaymentsSubscription?.cancel();
  }

  List<CashPayment> get cashPayments => state.cashPayments..sort((cashPayment1, cashPayment2) {
    Buyer buyer1 = buyerForCashPayment(cashPayment1);
    Buyer buyer2 = buyerForCashPayment(cashPayment2);
    int ordCompare = buyer1.name.toLowerCase().compareTo(buyer2.name.toLowerCase());

    return ordCompare == 0 ? cashPayment1.summ.compareTo(cashPayment2.summ) : ordCompare;
  });
  List<CardPayment> get cardPayments => state.cardPayments..sort((cardPayment1, cardPayment2) {
    Buyer buyer1 = buyerForCardPayment(cardPayment1);
    Buyer buyer2 = buyerForCardPayment(cardPayment2);
    int ordCompare = buyer1.name.toLowerCase().compareTo(buyer2.name.toLowerCase());

    return ordCompare == 0 ? cardPayment1.summ.compareTo(cardPayment2.summ) : ordCompare;
  });

  Buyer buyerForCardPayment(CardPayment cardPayment) => state.buyers.firstWhere((e) => e.id == cardPayment.buyerId);
  Buyer buyerForCashPayment(CashPayment cashPayment) => state.buyers.firstWhere((e) => e.id == cashPayment.buyerId);

  void startCancelPayment(CardPayment cardPayment) {
    emit(state.copyWith(
      status: PaymentsStateStatus.cancelStarted,
      cardPaymentToCancel: cardPayment
    ));
  }

  void finishCancelPayment(String result) {
    emit(state.copyWith(status: PaymentsStateStatus.cancelFinished, message: result));
  }
}
