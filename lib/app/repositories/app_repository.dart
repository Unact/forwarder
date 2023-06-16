import 'package:drift/drift.dart' show Value;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

class AppRepository extends BaseRepository {
  AppRepository(AppDataStore dataStore, Api api) : super(dataStore, api);

  Future<bool> get newVersionAvailable async {
    String currentVersion = (await PackageInfo.fromPlatform()).version;
    String remoteVersion = (await dataStore.usersDao.getUser()).version;

    return Version.parse(remoteVersion) > Version.parse(currentVersion);
  }

  Future<String> get fullVersion async {
    PackageInfo info = await PackageInfo.fromPlatform();

    return info.version + '+' + info.buildNumber;
  }

  Future<Pref> getPref() {
    return dataStore.getPref();
  }

  Future<ApiPaymentCredentials> getApiPaymentCredentials() async {
    try {
      return await api.getPaymentCredentials();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> loadData() async {
    try {
      ApiData data = await api.getData();

      await dataStore.transaction(() async {
        List<Recept> recepts = data.recepts.map((e) => e.toDatabaseEnt()).toList();
        List<Income> incomes = data.incomes.map((e) => e.toDatabaseEnt()).toList();
        List<CashPayment> cashPayments = data.cashPayments.map((e) => e.toDatabaseEnt()).toList();
        List<CardPayment> cardPayments = data.cardPayments.map((e) => e.toDatabaseEnt()).toList();
        List<Buyer> buyers = data.buyers.map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<OrderLine> orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        List<Debt> debts = data.debts.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.ordersDao.loadBuyers(buyers);
        await dataStore.ordersDao.loadIncomes(incomes);
        await dataStore.ordersDao.loadRecepts(recepts);
        await dataStore.ordersDao.loadOrders(orders);
        await dataStore.ordersDao.loadOrderLines(orderLines);
        await dataStore.paymentsDao.loadDebts(debts);
        await dataStore.paymentsDao.loadCashPayments(cashPayments);
        await dataStore.paymentsDao.loadCardPayments(cardPayments);
        await dataStore.updatePref(PrefsCompanion(lastSyncTime: Value(DateTime.now())));
      });
      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
