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

  Future<void> tryDeliverOrder(bool delivered) async {
    double volScanned = state.codeLines.fold(
      0,
      (acc, e) => acc + e.orderLineCodes.fold(0, (v, el) => v + el.amount)
    );
    double totalVolScanned = state.codeLines.fold(
      0,
      (acc, e) => acc + e.orderLine.vol
    );

    if (delivered && state.order.needScan && volScanned != totalVolScanned) {
      emit(state.copyWith(
        status: OrderStateStatus.needUserConfirmation,
        delivered: delivered,
        message: 'Не все товары отсканированы. Подтверждаете доставку?',
        confirmationCallback: deliverOrder
      ));

      return;
    }

    if (state.order.dovUnload && volScanned == 0) {
      await Future.wait(state.codeLines.map((e) {
        return e.orderLineStorageCodes.map((ie) {
          return ordersRepository.addOrderLineCode(
            orderLine: e.orderLine,
            code: ie.code,
            groupCode: ie.code,
            amount: ie.amount,
            isDataMatrix: true
          );
        });
      }).expand((e) => e));
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
      final location = await Geo.getCurrentPosition();

      await appRepository.syncData();
      await ordersRepository.deliveryOrder(
        state.order,
        state.delivered,
        state.codeLines.map((e) => e.orderLineCodes).expand((e) => e).toList(),
        location
      );

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

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Доставка успешно отменена'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> copyOrderInfo() async {
    await Clipboard.setData(ClipboardData(text: state.order.info));

    emit(state.copyWith(status: OrderStateStatus.orderDataCopied, message: 'Данные о заказе скопированы'));
  }
}
