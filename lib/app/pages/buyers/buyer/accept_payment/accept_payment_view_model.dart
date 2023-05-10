part of 'accept_payment_page.dart';

class AcceptPaymentViewModel extends PageViewModel<AcceptPaymentState, AcceptPaymentStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;
  Iboxpro iboxpro = Iboxpro();

  AcceptPaymentViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required List<Debt> debts,
      required bool isCard
    }
  ) : super(
    AcceptPaymentState(debts: debts, isCard: isCard, message: 'Инициализация платежа'),
    [appRepository, ordersRepository, paymentsRepository]
  );

  @override
  AcceptPaymentStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<int> orderIds = state.debts.map(((e) => e.orderId)).toList();
    List<Order> orders = (await ordersRepository.getOrders()).where((e) => orderIds.contains(e.id)).toList();

    emit(state.copyWith(
      status: AcceptPaymentStateStatus.dataLoaded,
      orders: orders
    ));
  }

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    await _checkOrders();
  }

  Future<void> _checkOrders() async {
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
    emit(state.copyWith(location: await GeoLoc.getCurrentLocation()));

    if (state.location == null) {
      emit(state.copyWith(message: Strings.locationNotFound, status: AcceptPaymentStateStatus.failure));
      return;
    }

    if (!state.isCard) {
      _savePayment();
    } else {
      _connectToDevice();
    }
  }

  Future<void> cancelPayment() async {
    await iboxpro.cancelPayment();

    emit(state.copyWith(message: 'Платеж отменен', canceled: true, status: AcceptPaymentStateStatus.failure));
  }

  Future<void> _connectToDevice() async {
    if (!await Permissions.hasBluetoothPermission()) {
      emit(state.copyWith(message: 'Не разрешено соединение по Bluetooth', status: AcceptPaymentStateStatus.failure));
      return;
    }

    emit(state.copyWith(
      message: 'Установление связи с терминалом',
      status: AcceptPaymentStateStatus.searchingForDevice
    ));

    iboxpro.connectToDevice(
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onConnected: _getPaymentCredentials
    );
  }

  Future<void> _getPaymentCredentials() async {
    if (state.canceled) return;

    emit(state.copyWith(
      message: 'Установление связи с сервером',
      status: AcceptPaymentStateStatus.gettingCredentials
    ));

    try {
      ApiPaymentCredentials credentials = await appRepository.getApiPaymentCredentials();

      await _apiLogin(credentials.iboxLogin, credentials.iboxPassword);
    } on AppError catch(e) {
      emit(state.copyWith(message: e.message, status: AcceptPaymentStateStatus.failure));
    }
  }

  Future<void> _apiLogin(String login, String password) async {
    if (state.canceled) return;

    emit(state.copyWith(
      message: 'Авторизация оплаты',
      status: AcceptPaymentStateStatus.paymentAuthorization
    ));

    await iboxpro.apiLogin(
      login: login,
      password: password,
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onLogin: _startPayment
    );
  }

  Future<void> _startPayment() async {
    if (state.canceled) return;

    emit(state.copyWith(
      message: 'Ожидание ответа от терминала',
      status: AcceptPaymentStateStatus.waitingForPayment
    ));

    await iboxpro.startPayment(
      amount: state.debts.fold(0, (sum, e) => sum + e.paymentSum!),
      description: 'Оплата за заказ ${state.debts.map((debt) => debt.orderName).join(', ')}',
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onPaymentStart: (_) {
        emit(state.copyWith(
          isCancelable: false,
          message: 'Обработка оплаты',
          status: AcceptPaymentStateStatus.paymentStarted
        ));
      },
      onPaymentComplete: (Map<String, dynamic> transaction, bool requiredSignature) {
        emit(state.copyWith(
          isRequiredSignature: requiredSignature,
          message: 'Подтверждение оплаты',
          status: AcceptPaymentStateStatus.paymentFinished
        ));

        if (!requiredSignature) {
          _savePayment(transaction);
        } else {
          emit(state.copyWith(
            isRequiredSignature: requiredSignature,
            message: 'Для завершения оплаты\nнеобходимо указать подпись',
            status: AcceptPaymentStateStatus.requiredSignature
          ));
        }
      }
    );
  }

  Future<void> adjustPayment(Uint8List signature) async {
    emit(state.copyWith(
      isRequiredSignature: false,
      message: 'Сохранение подписи клиента',
      status: AcceptPaymentStateStatus.savingSignature
    ));

    await iboxpro.adjustPayment(
      signature: signature,
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onPaymentAdjust: _savePayment
    );
  }

  Future<void> _savePayment([Map<String, dynamic>? transaction]) async {
    emit(state.copyWith(
      message: 'Сохранение информации об оплате',
      status: AcceptPaymentStateStatus.savingPayment
    ));

    try {
      await paymentsRepository.acceptPayment(state.debts, transaction, state.location!);

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
