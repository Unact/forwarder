part of 'buyer_page.dart';

class BuyerViewModel extends PageViewModel<BuyerState, BuyerStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<BuyerEx>? buyerSubscription;
  StreamSubscription<List<Order>>? orderSubscription;
  StreamSubscription<List<Debt>>? debtsSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;
  StreamSubscription<List<CardPayment>>? cardPaymentsSubscription;

  BuyerViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required BuyerEx buyer
    }
  ) :
    super(BuyerState(buyer: buyer, confirmationCallback: () {}));

  @override
  BuyerStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    buyerSubscription = ordersRepository.watchBuyerById(state.buyer.buyer.buyerId, state.buyer.buyer.deliveryId)
      .listen((event) {
        emit(state.copyWith(status: BuyerStateStatus.dataLoaded, buyer: event));
      });
    orderSubscription = ordersRepository.watchOrdersByBuyerId(state.buyer.buyer.buyerId, state.buyer.buyer.deliveryId)
      .listen((event) {
        emit(state.copyWith(status: BuyerStateStatus.dataLoaded, orders: event));
      });
    debtsSubscription = paymentsRepository.watchDebtsByBuyerId(state.buyer.buyer.buyerId).listen((event) {
      emit(state.copyWith(status: BuyerStateStatus.dataLoaded, debts: event.where((e) => !e.physical).toList()));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPaymentsByBuyerId(state.buyer.buyer.buyerId)
      .listen((event) {
        emit(state.copyWith(status: BuyerStateStatus.dataLoaded, cashPayments: event));
      });
    cardPaymentsSubscription = paymentsRepository.watchCardPaymentsByBuyerId(state.buyer.buyer.buyerId)
      .listen((event) {
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
    emit(state.copyWith(
      status: BuyerStateStatus.needUserConfirmation,
      confirmationCallback: depart,
      message: 'Вы уверены, что хотите покинуть точку?'
    ));
  }

  void tryArrive() {
    emit(state.copyWith(
      status: BuyerStateStatus.needUserConfirmation,
      confirmationCallback: arrive,
      message: 'Вы уверены, что хотите отметится в точке?'
    ));
  }

  void tryMissed() {
    emit(state.copyWith(
      status: BuyerStateStatus.needUserConfirmation,
      confirmationCallback: missed,
      message: 'Вы уверены, что хотите отметить непосещение точки?'
    ));
  }

  Future<void> missed(bool confirmed) async {
    await _markPoint(
      confirmed,
      (location) => ordersRepository.missed(state.buyer.buyer, location),
      'Отмечен недоезд до точки'
    );
  }

  Future<void> arrive(bool confirmed) async {
    await _markPoint(
      confirmed,
      (location) => ordersRepository.arrive(state.buyer.buyer, location),
      'Отмечен приезд в точку'
    );
  }

  Future<void> depart(bool confirmed) async {
    await _markPoint(
      confirmed,
      (location) => ordersRepository.depart(state.buyer.buyer, location),
      'Отмечен отъезд из точки'
    );
  }

  Future<void> _markPoint(bool confirmed, Future<void> Function(Position) action, String successMessage) async {
    if (!confirmed) return;

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
