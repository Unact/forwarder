part of 'person_page.dart';

class PersonViewModel extends PageViewModel<PersonState, PersonStateStatus> {
  static const String _kRepoUrl = 'https://unact.github.io/mobile_apps/forwarder';
  final AppRepository appRepository;
  final UsersRepository usersRepository;

  PersonViewModel(this.appRepository, this.usersRepository) : super(PersonState(), [appRepository, usersRepository]);

  @override
  PersonStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: PersonStateStatus.dataLoaded,
      user: await usersRepository.getUser(),
      pref: await appRepository.getPref(),
      fullVersion: await appRepository.fullVersion,
      newVersionAvailable: await appRepository.newVersionAvailable,
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
    String version = state.user!.version;
    String androidUpdateUrl = '$_kRepoUrl/releases/download/$version/app-release.apk';
    String iosUpdateUrl = 'itms-services://?action=download-manifest&url=$_kRepoUrl/manifest.plist';
    Uri uri = Uri.parse(Platform.isIOS ? iosUpdateUrl : androidUpdateUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      emit(state.copyWith(status: PersonStateStatus.failure, message: Strings.genericErrorMsg));
    }
  }
}
