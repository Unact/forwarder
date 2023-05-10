part of 'login_page.dart';

class LoginViewModel extends PageViewModel<LoginState, LoginStateStatus> {
  final AppRepository appRepository;
  final UsersRepository usersRepository;

  LoginViewModel(this.appRepository, this.usersRepository) : super(LoginState(), [appRepository, usersRepository]);

  @override
  LoginStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    String fullVersion = await appRepository.fullVersion;

    emit(state.copyWith(
      status: LoginStateStatus.dataLoaded,
      fullVersion: fullVersion
    ));
  }

  Future<void> apiLogin(String url, String login, String password) async {
    if (login == password && login == Strings.optsKeyword) {
      emit(state.copyWith(
        status: LoginStateStatus.urlFieldActivated,
        login: '',
        password: '',
        showUrl: true
      ));

      return;
    }

    if (login == '') {
      emit(state.copyWith(status: LoginStateStatus.failure, message: 'Не заполнено поле с логином'));
      return;
    }

    if (password == '') {
      emit(state.copyWith(status: LoginStateStatus.failure, message: 'Не заполнено поле с паролем'));
      return;
    }

    emit(state.copyWith(
      login: login,
      password: password,
      url: url,
      status: LoginStateStatus.inProgress
    ));

    try {
      await usersRepository.login(url, login, password);

      emit(state.copyWith(status: LoginStateStatus.loggedIn));
    } on AppError catch(e) {
      emit(state.copyWith(status: LoginStateStatus.failure, message: e.message));
    }
  }

  Future<void> getNewPassword(String url, String login) async {
    if (login == '') {
      emit(state.copyWith(status: LoginStateStatus.failure, message: 'Не заполнено поле с логином'));
      return;
    }

    emit(state.copyWith(
      login: login,
      password: '',
      url: url,
      status: LoginStateStatus.inProgress
    ));

    try {
      await usersRepository.resetPassword(url, login);
      emit(state.copyWith(status: LoginStateStatus.passwordSent, message: 'Пароль отправлен на почту'));
    } on AppError catch(e) {
      emit(state.copyWith(status: LoginStateStatus.failure, message: e.message));
    }
  }
}
