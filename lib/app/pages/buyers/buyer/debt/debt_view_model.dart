part of 'debt_page.dart';

class DebtViewModel extends PageViewModel<DebtState, DebtStateStatus> {
  final AppRepository appRepository;
  final PaymentsRepository paymentsRepository;

  DebtViewModel(
    this.appRepository,
    this.paymentsRepository,
    {
      required Debt debt
    }
  ) :
    super(
      DebtState(debt: debt, confirmationCallback: () {}),
      [appRepository, paymentsRepository]
    );

  @override
  DebtStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    Debt debt = await paymentsRepository.getDebtById(state.debt.id);

    emit(state.copyWith(
      status: DebtStateStatus.dataLoaded,
      debt: debt
    ));
  }

  Future<void> updatePaymentSum(double? newValue) async {
    await paymentsRepository.updateDebtPaymentSum(state.debt, newValue);
  }

  void tryStartPayment(bool isCard) {
    if (state.debt.paymentSum == null) {
      emit(state.copyWith(
        status: DebtStateStatus.paymentFailure,
        isCard: isCard,
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
