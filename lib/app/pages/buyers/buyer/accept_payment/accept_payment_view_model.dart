part of 'accept_payment_page.dart';

class AcceptPaymentViewModel extends PageViewModel<AcceptPaymentState, AcceptPaymentStateStatus> {
  static const int _kNumOfTries = 5;

  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;
  late Iboxpro iboxpro = Iboxpro(
    onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
    onLogin: _startPayment,
    onConnected: _getPaymentCredentials,
    onStart: (String id) {
      emit(state.copyWith(
        isCancelable: state.isLink,
        message: 'Обработка оплаты',
        status: AcceptPaymentStateStatus.paymentStarted
      ));
    },
    onComplete: (Map<String, dynamic> transaction, bool requiredSignature) {
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
    },
    onAdjust: _savePayment,
    onCheck: (Map<String, dynamic> transaction, bool finished) {
      if (finished) {
        _savePayment(transaction);
      } else {
        _checkPayment();
      }
    },
    onNeedExternalComplete: (String value) {
      emit(state.copyWith(
        message: 'Для оплаты отсканируйте QR-код',
        externalPaymentQR: value,
        status: AcceptPaymentStateStatus.waitingForExternalPayment
      ));

      _checkPayment();
    }
  );

  AcceptPaymentViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required List<Debt> debts,
      required bool isCard,
      required bool isLink
    }
  ) : super(
    AcceptPaymentState(debts: debts, isCard: isCard, isLink: isLink, message: 'Инициализация платежа'),
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

  @override
  Future<void> close() async {
    await super.close();
    iboxpro.dispose();
  }

  Future<void> _checkPayment() async {
    emit(state.copyWith(paymentChecked: state.paymentChecked + 1));

    if (state.paymentChecked > _kNumOfTries) {
      emit(state.copyWith(
        message: 'Истекло время ожидания оплаты СБП',
        status: AcceptPaymentStateStatus.failure
      ));
    }

    await Future.delayed(const Duration(seconds: 30));

    await iboxpro.checkPayment();
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
      return;
    }

    if (state.isLink) {
      _getPaymentCredentials();
      return;
    }

    _connectToDevice();
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

    await iboxpro.connectToDevice();
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

    await iboxpro.apiLogin(login: login, password: password);
  }

  Future<void> _startPayment() async {
    if (state.canceled) return;

    emit(state.copyWith(
      message: 'Ожидание ответа',
      status: AcceptPaymentStateStatus.waitingForPayment
    ));

    await iboxpro.startPayment(
      amount: state.debts.fold(0, (sum, e) => sum + e.paymentSum!),
      description: 'Оплата за заказ ${state.debts.map((debt) => debt.orderName).join(', ')}',
      isLink: state.isLink
    );
  }

  Future<void> adjustPayment(Uint8List signature) async {
    emit(state.copyWith(
      isRequiredSignature: false,
      message: 'Сохранение подписи клиента',
      status: AcceptPaymentStateStatus.savingSignature
    ));

    await iboxpro.adjustPayment(signature: signature);
  }

  Future<void> _savePayment([Map<String, dynamic>? transaction]) async {
    emit(state.copyWith(
      isCancelable: false,
      message: 'Сохранение информации об оплате',
      status: AcceptPaymentStateStatus.savingPayment
    ));

    try {
      await paymentsRepository.acceptPayment(state.orders, state.debts, transaction, state.location!);

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
