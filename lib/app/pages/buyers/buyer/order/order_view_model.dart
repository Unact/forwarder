part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  OrderViewModel(this.appRepository, this.ordersRepository, this.paymentsRepository, {required Order order}) :
    super(OrderState(order: order, confirmationCallback: () {}), [appRepository, ordersRepository, paymentsRepository]);

  @override
  OrderStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<OrderLineWithCode> codeLines = await ordersRepository.getOrderLinesByOrderId(state.order.id);
    Order order = await ordersRepository.getOrderById(state.order.id);
    Debt? debt = await paymentsRepository.getDebtByOrderId(state.order.id);

    emit(state.copyWith(
      status: OrderStateStatus.dataLoaded,
      codeLines: codeLines,
      order: order,
      debt: debt
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
    bool allVolScanned = state.codeLines.every(
      (e) => e.orderLine.vol == e.orderLineCodes.fold<int>(0, (v, el) => v + el.amount)
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

  void tryStartPayment(bool isCard) {
    if (state.debt == null) {
      emit(state.copyWith(status: OrderStateStatus.paymentFailure, message: 'Не найдена задолженность для заказа'));

      return;
    }

    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      isCard: isCard,
      message: 'Вы уверены, что хотите внести оплату ${Format.numberStr(state.debt!.paymentSum)} руб.?\n'
        'Изменить потом будет нельзя.',
      confirmationCallback: startPayment
    ));
  }
}
