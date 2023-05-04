part of 'landing_page.dart';

enum LandingStateStatus {
  initial,
}

class LandingState {
  LandingState({
    this.status = LandingStateStatus.initial,
    this.user,
    this.pref
  });

  final User? user;
  final Pref? pref;
  final LandingStateStatus status;
  bool get isLogged => user != null && user!.id != UsersDao.kGuestId;

  LandingState copyWith({
    LandingStateStatus? status,
    User? user,
    Pref? pref
  }) {
    return LandingState(
      status: status ?? this.status,
      user: user ?? this.user,
      pref: pref ?? this.pref
    );
  }
}
