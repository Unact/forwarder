part of 'person_page.dart';

class PersonViewModel extends PageViewModel<PersonState, PersonStateStatus> {
  final AppRepository appRepository;
  final BuyersRepository buyersRepository;
  final UsersRepository usersRepository;

  StreamSubscription<AppInfoResult>? appInfoSubscription;
  StreamSubscription<User>? userSubscription;

  PersonViewModel(
    this.appRepository,
    this.buyersRepository,
    this.usersRepository
  ) : super(PersonState(confirmationCallback: () {}));

  @override
  PersonStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    userSubscription = usersRepository.watchUser().listen((event) {
      emit(state.copyWith(status: PersonStateStatus.dataLoaded, user: event));
    });
    appInfoSubscription = appRepository.watchAppInfo().listen((event) {
      emit(state.copyWith(status: PersonStateStatus.dataLoaded, appInfo: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await userSubscription?.cancel();
    await appInfoSubscription?.cancel();
  }

  Future<void> apiLogout() async {
    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await usersRepository.logout();
      await appRepository.clearData();
      await buyersRepository.clearFiles();

      emit(state.copyWith(status: PersonStateStatus.loggedOut));
    } on AppError catch(e) {
      emit(state.copyWith(status: PersonStateStatus.failure, message: e.message));
    }
  }

  Future<void> tryGetData() async {
    if (state.appInfo?.hasUnsaved ?? false) {
      emit(state.copyWith(
        status: PersonStateStatus.needUserConfirmation,
        message: 'Присутствуют не сохраненные изменения. Продолжить?',
        confirmationCallback: getData
      ));

      return;
    }

    await getData(true);
  }

  Future<void> syncData() async {
    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await appRepository.syncData();

      emit(state.copyWith(status: PersonStateStatus.success));
    } on AppError catch(e) {
      emit(state.copyWith(status: PersonStateStatus.failure, message: e.message));
    }
  }

  Future<void> getData(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await usersRepository.loadUserData();
      await appRepository.loadData();

      emit(state.copyWith(status: PersonStateStatus.success));
    } on AppError catch(e) {
      emit(state.copyWith(status: PersonStateStatus.failure, message: e.message));
    }
  }

  Future<void> launchAppUpdate() async {
    Misc.launchAppUpdate(
      repoName: Strings.repoName,
      version: state.user!.version,
      onError: () => emit(state.copyWith(status: PersonStateStatus.failure, message: Strings.genericErrorMsg))
    );
  }
}
