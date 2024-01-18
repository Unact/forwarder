part of 'buyer_page.dart';

class BuyerViewModel extends PageViewModel<BuyerState, BuyerStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<Order>>? orderSubscription;
  StreamSubscription<List<Debt>>? debtsSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;
  StreamSubscription<List<CardPayment>>? cardPaymentsSubscription;

  BuyerViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required Buyer buyer,
      required bool isInc
    }
  ) :
    super(BuyerState(buyer: buyer, isInc: isInc, confirmationCallback: () {}));

  @override
  BuyerStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderSubscription = ordersRepository.watchOrdersByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, orders: event));
    });
    debtsSubscription = paymentsRepository.watchDebtsByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, debts: event));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPaymentsByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, cashPayments: event));
    });
    cardPaymentsSubscription = paymentsRepository.watchCardPaymentsByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, cardPayments: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderSubscription?.cancel();
    await debtsSubscription?.cancel();
    await cashPaymentsSubscription?.cancel();
    await cardPaymentsSubscription?.cancel();
  }

  Future<void> updateDebtPaymentSum(Debt debt, double? newValue) async {
    await paymentsRepository.updateDebtPaymentSum(debt, newValue);
  }

  void tryStartPayment(bool isCard) {
    List<Debt> debtsToPay = state.debts.where((e) => e.paymentSum != null).toList();
    double paymentSumTotal = debtsToPay.fold(0, (sum, e) => sum + e.paymentSum!);

    emit(state.copyWith(
      status: BuyerStateStatus.needUserConfirmation,
      isCard: isCard,
      confirmationCallback: startPayment,
      debtsToPay: debtsToPay,
      message: 'Вы уверены, что хотите внести оплату ${Format.numberStr(paymentSumTotal)} руб.?\n'
        'Изменить потом будет нельзя.'
    ));
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: BuyerStateStatus.paymentStarted));
  }

  void finishPayment(String result) {
    emit(state.copyWith(
      status: BuyerStateStatus.paymentFinished,
      message: result
    ));
  }
}
