part of 'buyer_page.dart';

class BuyerViewModel extends PageViewModel<BuyerState, BuyerStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<Buyer>? buyerSubscription;
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

    buyerSubscription = ordersRepository.watchBuyerById(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, buyer: event));
    });
    orderSubscription = ordersRepository.watchOrdersByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, orders: event));
    });
    debtsSubscription = paymentsRepository.watchDebtsByBuyerId(state.buyer.id).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, debts: event.where((e) => !e.physical).toList()));
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

    await buyerSubscription?.cancel();
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

  void tryDepart() {
    if (state.orders.any((e) => !e.didDelivery)) {
      emit(state.copyWith(
        status: BuyerStateStatus.needUserConfirmation,
        confirmationCallback: depart,
        message: 'Вы уверены, что хотите покинуть точку?'
      ));
      return;
    }

    depart(true);
  }

  Future<void> missed() async {
    await _markPoint(
      (location) => ordersRepository.missed(state.buyer, location),
      'Отмечен недоезд до точки'
    );
  }

  Future<void> arrive() async {
    await _markPoint(
      (location) => ordersRepository.arrive(state.buyer, location),
      'Отмечен приезд в точку'
    );
  }

  Future<void> depart(bool confirmed) async {
    if (!confirmed) return;

    await _markPoint(
      (location) => ordersRepository.depart(state.buyer, location),
      'Отмечен отъезд из точки'
    );
  }

  Future<void> _markPoint(Future<void> Function(Position) action, String successMessage) async {
    emit(state.copyWith(status: BuyerStateStatus.inProgress));

    try {
      if (!(await Permissions.hasLocationPermissions())) {
        emit(state.copyWith(
          message: 'Нет прав на получение местоположения',
          status: BuyerStateStatus.failure
        ));
        return;
      }

      final location = await Geolocator.getCurrentPosition();

      await action.call(location);

      emit(state.copyWith(status: BuyerStateStatus.success, message: successMessage));
    } on AppError catch(e) {
      emit(state.copyWith(status: BuyerStateStatus.failure, message: e.message));
    }
  }
}
