part of 'landing_page.dart';

class LandingViewModel extends PageViewModel<LandingState, LandingStateStatus> {
  final AppRepository appRepository;
  final UsersRepository usersRepository;

  LandingViewModel(this.appRepository, this.usersRepository) : super(LandingState(), [appRepository, usersRepository]);

  @override
  LandingStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await _maybeLogout();
    await super.initViewModel();
  }

  @override
  Future<void> loadData() async {
    User user = await usersRepository.getUser();

    emit(state.copyWith(
      status: LandingStateStatus.dataLoaded,
      user: user
    ));
  }

  Future<void> _maybeLogout() async {
    Pref pref = await appRepository.getPref();
    DateTime now = DateTime.now();
    DateTime? lastLogin = pref.lastLogin;

    if (lastLogin == null) return;
    if (now.day == lastLogin.day && now.difference(lastLogin).inDays < 1) return;

    await usersRepository.logout();
  }
}
