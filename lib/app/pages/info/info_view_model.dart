part of 'info_page.dart';

class InfoViewModel extends PageViewModel<InfoState, InfoStateStatus> {
  final AppRepository appRepository;
  final PaymentsRepository paymentsRepository;
  final UsersRepository usersRepository;

  StreamSubscription<User>? userSubscription;
  StreamSubscription<AppInfoResult>? appInfoSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;

  InfoViewModel(
    this.appRepository,
    this.paymentsRepository,
    this.usersRepository
  ) : super(InfoState());

  @override
  InfoStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    userSubscription = usersRepository.watchUser().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, user: event));
    });
    appInfoSubscription = appRepository.watchAppInfo().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, appInfo: event));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPayments().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, cashPayments: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await userSubscription?.cancel();
    await appInfoSubscription?.cancel();
    await cashPaymentsSubscription?.cancel();
  }

  Future<void> reverseDay() async {
    emit(state.copyWith(status: InfoStateStatus.reverseInProgress));

    try {
      await appRepository.syncData();
      await usersRepository.reverseDay();
      emit(state.copyWith(
        status: InfoStateStatus.reverseSuccess,
        message: 'День успешно ${state.closed ? 'открыт' : 'закрыт'}'
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.reverseFailure, message: e.message));
    }
  }
}
