part of 'accept_payment_page.dart';

class AcceptPaymentViewModel extends PageViewModel<AcceptPaymentState, AcceptPaymentStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  AcceptPaymentViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required List<Debt> debts
    }
  ) : super(AcceptPaymentState(debts: debts, message: 'Инициализация платежа'),);

  @override
  AcceptPaymentStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    await _checkOrders();
  }

  Future<void> _checkOrders() async {
    List<int> orderIds = state.debts.map(((e) => e.orderId)).toList();
    List<Order> orders = (await ordersRepository.watchOrders().first).where((e) => orderIds.contains(e.id)).toList();

    emit(state.copyWith(status: AcceptPaymentStateStatus.dataLoaded, orders: orders));

    if (state.orders.any((element) => element.isUndelivered && element.physical)) {
      emit(state.copyWith(
        message: 'Присутствуют не доставленные заказы физ. лиц',
        status: AcceptPaymentStateStatus.failure
      ));
      return;
    }

    _getLocation();
  }

  Future<void> _getLocation() async {
    emit(state.copyWith(position: await Geolocator.getCurrentPosition()));
    _savePayment();
  }

  Future<void> _savePayment() async {
    emit(state.copyWith(
      message: 'Сохранение информации об оплате',
      status: AcceptPaymentStateStatus.savingPayment
    ));

    try {
      await paymentsRepository.acceptPayment(state.orders, state.debts, state.position!);

      emit(state.copyWith(
        message: 'Оплата успешно сохранена',
        status: AcceptPaymentStateStatus.finished
      ));
    } on AppError catch(e) {
      emit(state.copyWith(
        message: 'Ошибка при сохранении оплаты ${e.message}',
        status: AcceptPaymentStateStatus.failure
      ));
    }
  }
}
