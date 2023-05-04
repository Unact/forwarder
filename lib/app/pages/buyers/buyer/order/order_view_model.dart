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
    emit(state.copyWith(
      status: OrderStateStatus.dataLoaded,
      order: await ordersRepository.getOrderById(state.order.id)
    ));
  }

  void tryDeliverOrder(bool delivered) {
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

      await ordersRepository.deliveryOrder(state.order, state.delivered, location);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Информация о доставке сохранена'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }
}
