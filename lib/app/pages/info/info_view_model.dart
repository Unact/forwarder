part of 'info_page.dart';

class InfoViewModel extends PageViewModel<InfoState, InfoStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  final PaymentsRepository paymentsRepository;
  final UsersRepository usersRepository;

  InfoViewModel(
    this.appRepository,
    this.ordersRepository,
    this.paymentsRepository,
    this.usersRepository
  ) : super(InfoState(), [appRepository, ordersRepository, paymentsRepository, usersRepository]);

  @override
  InfoStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    await _checkNeedRefresh();
  }

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: InfoStateStatus.dataLoaded,
      newVersionAvailable: await appRepository.newVersionAvailable,
      user: await usersRepository.getUser(),
      pref: await appRepository.getPref(),
      buyers: await ordersRepository.getBuyers(),
      orders: await ordersRepository.getOrders(),
      cardPayments: await paymentsRepository.getCardPayments(),
      cashPayments: await paymentsRepository.getCashPayments()
    ));
  }

  Future<void> getData() async {
    if (state.isBusy) return;

    Location? location = await GeoLoc.getCurrentLocation();

    if (location == null) {
      emit(state.copyWith(
        status: InfoStateStatus.failure,
        message: 'Для работы с приложением необходимо разрешить определение местоположения'
      ));

      return;
    }

    emit(state.copyWith(status: InfoStateStatus.inProgress));

    try {
      await usersRepository.loadUserData();
      await appRepository.loadData();

      emit(state.copyWith(status: InfoStateStatus.success, message: 'Данные успешно обновлены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.failure, message: e.message));
    }
  }

  Future<void> reverseDay() async {
    emit(state.copyWith(status: InfoStateStatus.reverseInProgress));

    try {
      await usersRepository.reverseDay();
      emit(state.copyWith(
        status: InfoStateStatus.reverseSuccess,
        message: 'День успешно ${state.closed ? 'закрыт' : 'открыт'}'
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.reverseFailure, message: e.message));
    }
  }

  Future<void> _checkNeedRefresh() async {
    if (state.isBusy) return;

    if (state.pref?.lastSyncTime == null) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
      return;
    }

    DateTime lastAttempt = state.pref!.lastSyncTime!;
    DateTime time = DateTime.now();

    if (lastAttempt.year != time.year || lastAttempt.month != time.month || lastAttempt.day != time.day) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
    }
  }
}
