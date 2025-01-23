part of 'debt_page.dart';

enum DebtStateStatus {
  initial,
  dataLoaded,
  needUserConfirmation,
  debtChanged,
  paymentStarted,
  paymentFailure,
  paymentFinished
}

class DebtState {
  DebtState({
    this.status = DebtStateStatus.initial,
    required this.debt,
    required this.confirmationCallback,
    this.message = ''
  });

  final DebtStateStatus status;
  final Debt debt;
  final Function confirmationCallback;
  final String message;

  bool get isEditable => debt.debtSum > 0;

  DebtState copyWith({
    DebtStateStatus? status,
    Debt? debt,
    Function? confirmationCallback,
    String? message
  }) {
    return DebtState(
      status: status ?? this.status,
      debt: debt ?? this.debt,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      message: message ?? this.message
    );
  }
}
