part of 'debt_page.dart';

class DebtViewModel extends PageViewModel<DebtState, DebtStateStatus> {
  final AppRepository appRepository;
  final PaymentsRepository paymentsRepository;

  StreamSubscription<Debt>? debtSubscription;

  DebtViewModel(
    this.appRepository,
    this.paymentsRepository,
    {
      required Debt debt
    }
  ) : super(DebtState(debt: debt, confirmationCallback: () {}));

  @override
  DebtStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    debtSubscription = paymentsRepository.watchDebtById(state.debt.id).listen((event) {
      emit(state.copyWith(status: DebtStateStatus.dataLoaded, debt: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await debtSubscription?.cancel();
  }

  Future<void> updatePaymentSum(double? newValue) async {
    await paymentsRepository.updateDebtPaymentSum(state.debt, newValue);
  }

  void tryStartPayment(bool isCard) {
    if (state.debt.paymentSum == null) {
      emit(state.copyWith(
        status: DebtStateStatus.paymentFailure,
        confirmationCallback: startPayment,
        message: 'Указана некорректная сумма'
      ));

      return;
    }

    emit(state.copyWith(
      status: DebtStateStatus.needUserConfirmation,
      isCard: isCard,
      confirmationCallback: startPayment,
      message: 'Вы уверены, что хотите внести оплату ${Format.numberStr(state.debt.paymentSum)} руб.?\n'
        'Изменить потом будет нельзя.'
    ));
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: DebtStateStatus.paymentStarted));
  }

  void finishPayment(String result) async {
    emit(state.copyWith(status: DebtStateStatus.paymentFinished, message: result));
  }
}
