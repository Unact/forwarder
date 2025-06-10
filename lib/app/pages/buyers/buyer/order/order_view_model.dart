part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<OrderLineWithCode>>? orderLineWithCodeListSubscription;
  StreamSubscription<Order>? orderSubscription;
  StreamSubscription<Debt?>? debtSubscription;

  OrderViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository, {required Order order}) :
    super(OrderState(order: order, confirmationCallback: () {}));

  @override
  OrderStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderLineWithCodeListSubscription = ordersRepository.watchOrderLinesByOrderId(state.order.id).listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, codeLines: event));
    });
    orderSubscription = ordersRepository.watchOrderById(state.order.id).listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, order: event));
    });
    debtSubscription = paymentsRepository.watchDebtByOrderId(state.order.id).listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, debt: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineWithCodeListSubscription?.cancel();
    await orderSubscription?.cancel();
    await debtSubscription?.cancel();
  }

  Future<void> clearOrderLineCodes(OrderLineWithCode codeLine) async {
    await ordersRepository.clearOrderLineCodesByOrderLineSubid(codeLine.orderLine);
  }

  void tryShowScan() async {
    if (!await Permissions.hasCameraPermissions()) {
      emit(state.copyWith(message: 'Не разрешено использование камеры', status: OrderStateStatus.failure));
      return;
    }

    emit(state.copyWith(status: OrderStateStatus.showScan));
  }

  void tryDeliverOrder(bool delivered) {
    bool allVolScanned = state.codeLines.every(
      (e) => e.orderLine.vol == e.orderLineCodes.fold<int>(0, (v, el) => v + el.amount)
    );
    bool allStorageVolScanned = state.codeLines.every(
      (e) => e.orderLineStorageCodes.fold<int>(0, (v, el) => v + el.amount) ==
        e.orderLineCodes.where((e) => e.isDataMatrix).fold<int>(0, (v, el) => v + el.amount)
    );

    if (delivered && state.order.physical && !allVolScanned) {
      emit(state.copyWith(
        status: OrderStateStatus.needUserConfirmation,
        delivered: delivered,
        message: 'Не все товары отсканированы. Подтверждаете доставку?',
        confirmationCallback: deliverOrder
      ));

      return;
    }

    if (delivered && state.codeLines.any((e) => e.orderLineStorageCodes.isNotEmpty) && !allStorageVolScanned) {
      emit(state.copyWith(
        status: OrderStateStatus.needUserConfirmation,
        delivered: delivered,
        message: 'Не все товары, переданные складом, отсканированы. Подтверждаете доставку?',
        confirmationCallback: deliverOrder
      ));

      return;
    }

    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      delivered: delivered,
      message: delivered ? 'Передан заказ?' : 'Не передан заказ?',
      confirmationCallback: deliverOrder
    ));
  }

  Future<void> deliverOrder(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      if (!(await Permissions.hasLocationPermissions())) {
        emit(state.copyWith(
          message: 'Нет прав на получение местоположения',
          status: OrderStateStatus.failure
        ));
        return;
      }

      final location = await Geolocator.getCurrentPosition();

      await ordersRepository.deliveryOrder(
        state.order,
        state.delivered,
        state.codeLines.map((e) => e.orderLineCodes).expand((e) => e).toList(),
        location
      );
      await appRepository.loadData();

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Информация о доставке сохранена'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.paymentStarted));
  }

  void finishPayment(String result) async {
    emit(state.copyWith(status: OrderStateStatus.paymentFinished, message: result));
  }

  void tryStartPayment() {
    if (state.debt == null) {
      emit(state.copyWith(status: OrderStateStatus.paymentFailure, message: 'Не найдена задолженность для заказа'));

      return;
    }

    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      message: 'Вы уверены, что хотите внести оплату ${Format.numberStr(state.debt!.paymentSum)} руб.?\n'
        'Изменить потом будет нельзя.',
      confirmationCallback: startPayment
    ));
  }

  void tryCancelOrderDelivery() {
    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,

      message: 'Вы уверены, что хотите отменить доставку заказа?',
      confirmationCallback: cancelOrderDelivery
    ));
  }

  Future<void> cancelOrderDelivery(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await ordersRepository.cancelOrderDelivery(state.order);
      await appRepository.loadData();

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Доставка успешно отменена'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }
}
