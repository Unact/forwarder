part of 'payments_page.dart';

class PaymentsViewModel extends PageViewModel<PaymentsState, PaymentsStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  PaymentsViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository) :
    super(PaymentsState(), [appRepository, ordersRepository, paymentsRepository]);

  @override
  PaymentsStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: PaymentsStateStatus.dataLoaded,
      buyers: await ordersRepository.getBuyers(),
      cardPayments: await paymentsRepository.getCardPayments(),
      cashPayments: await paymentsRepository.getCashPayments(),
    ));
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
