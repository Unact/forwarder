part of 'person_page.dart';

enum PersonStateStatus {
  initial,
  dataLoaded,
  inProgress,
  loggedOut,
  failure,
  success,
  needUserConfirmation
}

class PersonState {
  PersonState({
    this.status = PersonStateStatus.initial,
    this.user,
    this.appInfo,
    required this.confirmationCallback,
    this.message = '',
  });

  final String message;
  final User? user;
  final Function confirmationCallback;
  final AppInfoResult? appInfo;
  final PersonStateStatus status;

  String get username => user?.username ?? '';
  String get salesmanName => user?.salesmanName ?? '';

  PersonState copyWith({
    PersonStateStatus? status,
    User? user,
    AppInfoResult? appInfo,
    String? message,
    Function? confirmationCallback
  }) {
    return PersonState(
      status: status ?? this.status,
      user: user ?? this.user,
      appInfo: appInfo ?? this.appInfo,
      message: message ?? this.message,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback
    );
  }
}
