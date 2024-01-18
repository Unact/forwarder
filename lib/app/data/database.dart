import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:rxdart/rxdart.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';

part 'schema.dart';
part 'database.g.dart';
part 'orders_dao.dart';
part 'payments_dao.dart';
part 'users_dao.dart';

@DriftDatabase(
  tables: [
    Users,
    Recepts,
    Incomes,
    Buyers,
    CardPayments,
    CashPayments,
    Debts,
    Orders,
    OrderLines,
    OrderLineCodes,
    Prefs
  ],
  daos: [
    OrdersDao,
    PaymentsDao,
    UsersDao
  ],
   queries: {
    'appInfo': '''
      SELECT
        prefs.*,
        (SELECT COUNT(*) FROM orders) orders_total,
        (SELECT COUNT(*) FROM orders WHERE is_inc = 1) +
          (
            SELECT COUNT(*)
            FROM orders
            WHERE NOT EXISTS(SELECT 1 FROM buyers WHERE buyers.id = orders.buyer_id) = 1
          ) inc_orders_total,
        (SELECT COUNT(*) FROM buyers) buyers_total
      FROM prefs
    '''
  },
)
class AppDataStore extends _$AppDataStore {
  AppDataStore({
    required bool logStatements
  }) : super(_openConnection(logStatements));

  Stream<AppInfoResult> watchAppInfo() {
    return appInfo().watchSingle();
  }

  Future<int> updatePref(PrefsCompanion pref) {
    return update(prefs).write(pref);
  }

  Future<void> clearData() async {
    await transaction(() async {
      await _clearData();
      await _populateData();
    });
  }

  Future<void> _clearData() async {
    await batch((batch) {
      for (var table in allTables) {
        batch.deleteWhere(table, (row) => const Constant(true));
      }
    });
  }

  Future<void> _populateData() async {
    await batch((batch) {
      batch.insert(users, const User(
        id: UsersDao.kGuestId,
        username: UsersDao.kGuestUsername,
        email: '',
        salesmanName: '',
        version: '0.0.0',
        total: 0,
        closed: false
      ));
      batch.insert(prefs, const Pref());
    });
  }

  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      for (final table in allTables) {
        await m.deleteTable(table.actualTableName);
        await m.createTable(table);
      }
    },
    beforeOpen: (details) async {
      if (details.hadUpgrade || details.wasCreated) await _populateData();
    },
  );
}

LazyDatabase _openConnection(bool logStatements) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '${Strings.appName}.sqlite'));

    return NativeDatabase(file, logStatements: logStatements);
  });
}

extension DebtX on Debt {
  String get orderName => '$orderNdoc от ${Format.dateStr(orderDdate)}';
  String get fullname => '$ndoc от ${Format.dateStr(ddate)} ($orderNdoc)';
}

extension OrderX on Order {
  bool get isDelivered => didDelivery && delivered! == true;
  bool get isUndelivered => didDelivery && delivered! == false;
  bool get didDelivery => delivered != null;
}

extension UserX on User {
  Future<bool> get newVersionAvailable async {
    final currentVersion = (await PackageInfo.fromPlatform()).version;

    return Version.parse(version) > Version.parse(currentVersion);
  }
}

class OrderLineBarcode {
  int rel;
  String barcode;

  OrderLineBarcode(this.barcode, this.rel);

  factory OrderLineBarcode.fromDart(String value) => OrderLineBarcode(
    value.split('-').first,
    int.parse(value.split('-').last)
  );

  String toDart() => "$barcode-$rel";
}
