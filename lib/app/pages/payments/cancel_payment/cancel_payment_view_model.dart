part of 'cancel_payment_page.dart';

class CancelPaymentViewModel extends PageViewModel<CancelPaymentState, CancelPaymentStateStatus> {
  final AppRepository appRepository;
  final PaymentsRepository paymentsRepository;
  final Iboxpro iboxpro = Iboxpro();

  CancelPaymentViewModel(
    this.appRepository,
    this.paymentsRepository,
    {
      required CardPayment cardPayment
    }
  ) : super(
    CancelPaymentState(message: 'Инициализация отмены', cardPayment: cardPayment),
    [appRepository, paymentsRepository]
  );

  @override
  CancelPaymentStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    _connectToDevice();
  }

  Future<void> cancelPayment() async {
    await iboxpro.cancelPayment();

    emit(state.copyWith(message: 'Платеж отменен', canceled: true, status: CancelPaymentStateStatus.failure));
  }

  Future<void> _connectToDevice() async {
    if (!await Permissions.hasBluetoothPermission()) {
      emit(state.copyWith(message: 'Не разрешено соединение по Bluetooth', status: CancelPaymentStateStatus.failure));
      return;
    }

    emit(state.copyWith(
      message: 'Установление связи с терминалом',
      status: CancelPaymentStateStatus.searchingForDevice
    ));

    iboxpro.connectToDevice(
      onError: (String error) => emit(state.copyWith(message: error, status: CancelPaymentStateStatus.failure)),
      onConnected: _getPaymentCredentials
    );
  }

  Future<void> _getPaymentCredentials() async {
    if (state.canceled) return;

    emit(state.copyWith(
      message: 'Установление связи с сервером',
      status: CancelPaymentStateStatus.gettingCredentials
    ));

    try {
      ApiPaymentCredentials credentials = await appRepository.getApiPaymentCredentials();

      await _apiLogin(credentials.iboxLogin, credentials.iboxPassword);
    } on AppError catch(e) {
      emit(state.copyWith(message: e.message, status: CancelPaymentStateStatus.failure));
    }
  }

  Future<void> _apiLogin(String login, String password) async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Авторизация оплаты', status: CancelPaymentStateStatus.paymentAuthorization));

    await iboxpro.apiLogin(
      login: login,
      password: password,
      onError: (String error) => emit(state.copyWith(message: error, status: CancelPaymentStateStatus.failure)),
      onLogin: _startReversePayment
    );
  }

  Future<void> _startReversePayment() async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Ожидание ответа от терминала', status: CancelPaymentStateStatus.waitingForPayment));

    await iboxpro.startReversePayment(
      id: state.cardPayment.transactionId!,
      amount: state.cardPayment.summ,
      description: 'Отмена заказа',
      onError: (String error) => emit(state.copyWith(message: error, status: CancelPaymentStateStatus.failure)),
      onPaymentStart: (_) {
        emit(state.copyWith(
          isCancelable: false,
          message: 'Обработка отмены',
          status: CancelPaymentStateStatus.paymentStarted
        ));
      },
      onPaymentComplete: (Map<String, dynamic> transaction, bool requiredSignature) {
        emit(state.copyWith(
          isRequiredSignature: requiredSignature,
          message: 'Подтверждение отмены',
          status: CancelPaymentStateStatus.paymentFinished
        ));

        if (!requiredSignature) {
          _savePayment(transaction);
        } else {
          emit(state.copyWith(
            message: 'Для завершения отмены\nнеобходимо указать подпись',
            status: CancelPaymentStateStatus.requiredSignature
          ));
        }
      }
    );
  }

  Future<void> adjustReversePayment(Uint8List signature) async {
    emit(state.copyWith(
      isRequiredSignature: false,
      message: 'Сохранение подписи клиента',
      status: CancelPaymentStateStatus.savingSignature
    ));

    await iboxpro.adjustReversePayment(
      signature: signature,
      onError: (String error) => emit(state.copyWith(message: error, status: CancelPaymentStateStatus.failure)),
      onReversePaymentAdjust: _savePayment
    );
  }

  Future<void> _savePayment(Map<String, dynamic> transaction) async {
    emit(state.copyWith(
      isRequiredSignature: false,
      message: 'Сохранение информации об отмене',
      status: CancelPaymentStateStatus.savingPayment
    ));

    try {
      await paymentsRepository.cancelCardPayment(state.cardPayment, transaction);
      await appRepository.loadData();

      emit(state.copyWith(
        message: 'Отмена успешно сохранена',
        status: CancelPaymentStateStatus.finished
      ));
    } on AppError catch(e) {
      emit(state.copyWith(
        message: 'Ошибка при сохранении отмены ${e.message}',
        status: CancelPaymentStateStatus.failure
      ));
    }
  }
}
