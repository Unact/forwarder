part of 'person_page.dart';

class PersonViewModel extends PageViewModel<PersonState, PersonStateStatus> {
  final AppRepository appRepository;
  final UsersRepository usersRepository;

  PersonViewModel(this.appRepository, this.usersRepository) : super(PersonState(), [appRepository, usersRepository]);

  @override
  PersonStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    User user = await usersRepository.getUser();
    Pref pref = await appRepository.getPref();
    String fullVersion = await appRepository.fullVersion;
    bool newVersionAvailable = await appRepository.newVersionAvailable;

    emit(state.copyWith(
      status: PersonStateStatus.dataLoaded,
      user: user,
      pref: pref,
      fullVersion: fullVersion,
      newVersionAvailable: newVersionAvailable
    ));
  }

  Future<void> apiLogout() async {
    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await usersRepository.logout();

      emit(state.copyWith(status: PersonStateStatus.loggedOut));
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
