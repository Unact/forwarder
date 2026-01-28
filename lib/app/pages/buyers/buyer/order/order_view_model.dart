part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<List<OrderLineWithCode>>? orderLineWithCodeListSubscription;
  StreamSubscription<Order>? orderSubscription;
  StreamSubscription<List<Debt>>? debtsSubscription;

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
    debtsSubscription = paymentsRepository.watchDebtsByOrderId(state.order.id).listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, debts: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineWithCodeListSubscription?.cancel();
    await orderSubscription?.cancel();
    await debtsSubscription?.cancel();
  }

  Future<void> clearOrderLineCodes(OrderLineWithCode codeLine) async {
    await ordersRepository.clearOrderLineCodesByOrderLineSubid(codeLine.orderLine);
  }

  Future<void> deleteOrderLinePackError(OrderLinePackError packError) async {
    await ordersRepository.deleteOrderLinePackErrorByOrderLineSubid(packError);
  }

  Future<void> addPackError(OrderLine orderLine, double volume) async {
    if (orderLine.vol < volume) {
      emit(state.copyWith(
        message: 'Количество недовложения не может быть больше чем количество позиции',
        status: OrderStateStatus.failure)
      );
      return;
    }

    await ordersRepository.addOrderLinePackError(orderLine: orderLine, volume: volume);
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
        state.codeLines.map((e) => e.orderLinePackErrors).expand((e) => e).toList(),
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
    if (state.debts.isEmpty) {
      emit(state.copyWith(status: OrderStateStatus.paymentFailure, message: 'Не найдены задолженности для заказа'));

      return;
    }

    final paymentSumStr = Format.numberStr(state.debts.fold<double>(0, (sum, debt) => sum + (debt.paymentSum ?? 0)));

    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      message: 'Вы уверены, что хотите внести оплату $paymentSumStr руб.?\nИзменить потом будет нельзя.',
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
