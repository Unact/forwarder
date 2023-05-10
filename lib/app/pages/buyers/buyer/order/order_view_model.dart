part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;

  OrderViewModel(this.appRepository, this.ordersRepository, {required Order order}) :
    super(OrderState(order: order, confirmationCallback: () {}), [appRepository, ordersRepository]);

  @override
  OrderStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<OrderLineWithCode> codeLines = await ordersRepository.getOrderLinesByOrderId(state.order.id);
    Order order = await ordersRepository.getOrderById(state.order.id);

    emit(state.copyWith(
      status: OrderStateStatus.dataLoaded,
      codeLines: codeLines,
      order: order
    ));
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
    if (delivered && state.markingCodeLines.any((e) => e.orderLine.vol != e.orderLineCodes.length)) {
      emit(state.copyWith(
        status: OrderStateStatus.needUserConfirmation,
        delivered: delivered,
        message: 'Не все товары с маркировкой отсканированы. Подтверждаете доставку?',
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
      Location? location = await GeoLoc.getCurrentLocation();

      if (location == null) {
        emit(state.copyWith(status: OrderStateStatus.failure, message: Strings.locationNotFound));
        return;
      }

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
}
