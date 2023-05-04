import 'package:drift/drift.dart' show Value;

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

class UsersRepository extends BaseRepository {
  UsersRepository(AppDataStore dataStore) : super(dataStore);

  Future<User> getUser() {
    return dataStore.usersDao.getUser();
  }

  Future<void> loadUserData() async {
    try {
      ApiUserData userData = await api.getUserData();

      await dataStore.usersDao.loadUser(userData.toDatabaseEnt());
      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> login(String url, String login, String password) async {
    try {
      await Api(dataStore: dataStore).login(url: url, login: login, password: password);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await loadUserData();
    await dataStore.updatePref(PrefsCompanion(lastLogin: Value(DateTime.now())));
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await Api(dataStore: dataStore).logout();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.clearData();
    notifyListeners();
  }

  Future<void> resetPassword(String url, String login) async {
    try {
      await api.resetPassword(url: url, login: login);
      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> reverseDay() async {
    try {
      User user = await dataStore.usersDao.getUser();
      bool closed = !user.closed;

      await api.closeDay(closed);
      await dataStore.usersDao.loadUser(user.copyWith(closed: !user.closed));

      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
