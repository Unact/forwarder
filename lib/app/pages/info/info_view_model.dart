part of 'info_page.dart';

class InfoViewModel extends PageViewModel<InfoState, InfoStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;
  final UsersRepository usersRepository;

  StreamSubscription<User>? userSubscription;
  StreamSubscription<AppInfoResult>? appInfoSubscription;
  StreamSubscription<List<CashPayment>>? cashPaymentsSubscription;
  StreamSubscription<List<CardPayment>>? cardPaymentsSubscription;

  InfoViewModel(
    this.appRepository,
    this.ordersRepository,
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
    cardPaymentsSubscription = paymentsRepository.watchCardPayments().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, cardPayments: event));
    });
    cashPaymentsSubscription = paymentsRepository.watchCashPayments().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, cashPayments: event));
    });

    await _checkNeedRefresh();
  }

  @override
  Future<void> close() async {
    await super.close();

    await userSubscription?.cancel();
    await appInfoSubscription?.cancel();
    await cardPaymentsSubscription?.cancel();
    await cashPaymentsSubscription?.cancel();
  }

  Future<void> getData() async {
    await usersRepository.loadUserData();
    await appRepository.loadData();
  }

  Future<void> reverseDay() async {
    emit(state.copyWith(status: InfoStateStatus.reverseInProgress));

    try {
      await usersRepository.reverseDay();
      emit(state.copyWith(
        status: InfoStateStatus.reverseSuccess,
        message: 'День успешно ${state.closed ? 'открыт' : 'закрыт'}'
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.reverseFailure, message: e.message));
    }
  }

  Future<void> _checkNeedRefresh() async {
    final pref = await appRepository.watchAppInfo().first;

    if (pref.lastLoadTime == null) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
      return;
    }

    DateTime lastAttempt = pref.lastLoadTime!;
    DateTime time = DateTime.now();

    if (lastAttempt.year != time.year || lastAttempt.month != time.month || lastAttempt.day != time.day) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
    }
  }
}
