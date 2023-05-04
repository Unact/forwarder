part of 'buyer_page.dart';

class BuyerViewModel extends PageViewModel<BuyerState, BuyerStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;

  BuyerViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    {
      required Buyer buyer,
      required bool isInc
    }
  ) :
    super(
      BuyerState(buyer: buyer, isInc: isInc, confirmationCallback: () {}),
      [appRepository, ordersRepository, paymentsRepository]
    );

  @override
  BuyerStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: BuyerStateStatus.dataLoaded,
      orders: await ordersRepository.getOrdersByBuyerId(state.buyer.id),
      debts: await paymentsRepository.getDebtsByBuyerId(state.buyer.id),
      cardPayments: await paymentsRepository.getCardPaymentsByBuyerId(state.buyer.id),
      cashPayments: await paymentsRepository.getCashPaymentsByBuyerId(state.buyer.id)
    ));
  }

  Future<void> updateDebtPaymentSum(Debt debt, double? newValue) async {
    await paymentsRepository.updateDebtPaymentSum(debt, newValue);
  }

  void tryStartPayment(bool isCard) {
    List<Debt> debtsToPay = state.debts.where((e) => e.paymentSum != null).toList();
    double paymentSumTotal = debtsToPay.fold(0, (sum, e) => sum + e.paymentSum!);

    emit(state.copyWith(
      status: BuyerStateStatus.needUserConfirmation,
      isCard: isCard,
      confirmationCallback: startPayment,
      debtsToPay: debtsToPay,
      message: 'Вы уверены, что хотите внести оплату ${Format.numberStr(paymentSumTotal)} руб.?\n'
        'Изменить потом будет нельзя.'
    ));
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: BuyerStateStatus.paymentStarted));
  }

  void finishPayment(String result) {
    emit(state.copyWith(
      status: BuyerStateStatus.paymentFinished,
      message: result
    ));
  }
}
