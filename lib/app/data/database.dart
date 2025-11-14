import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
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
part 'buyers_dao.dart';
part 'orders_dao.dart';
part 'payments_dao.dart';
part 'users_dao.dart';

@DriftDatabase(
  tables: [
    Users,
    Recepts,
    Incomes,
    Buyers,
    CashPayments,
    Debts,
    Orders,
    OrderLines,
    OrderLineCodes,
    OrderLineStorageCodes,
    OrderLinePackErrors,
    BuyerDeliveryMarks,
    BuyerDeliveryPoints,
    BuyerDeliveryPointPhotos,
    Prefs
  ],
  daos: [
    BuyersDao,
    OrdersDao,
    PaymentsDao,
    UsersDao
  ],
   queries: {
    'appInfo': '''
      SELECT
        prefs.*,
        (SELECT COUNT(*) FROM orders) orders_total,
        EXISTS(SELECT 1 FROM buyer_delivery_marks WHERE id IS NULL) has_unsynced,
        EXISTS(SELECT 1 FROM buyer_delivery_marks WHERE id IS NULL) OR
          EXISTS(SELECT 1 FROM order_line_codes WHERE id IS NULL) has_unsaved,
        (SELECT COUNT(*) FROM orders WHERE is_inc = 1) +
          (
            SELECT COUNT(*)
            FROM orders
            WHERE NOT EXISTS(SELECT 1 FROM buyers WHERE buyers.buyer_id = orders.buyer_id) = 1
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

  Future<void> _loadData(TableInfo table, Iterable<Insertable> rows, [bool clearTable = true]) async {
    await batch((batch) {
      if (clearTable) batch.deleteWhere(table, (row) => const Constant(true));
      batch.insertAll(table, rows, mode: InsertMode.insertOrReplace);
    });
  }

  @override
  int get schemaVersion => 23;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      for (final entity in allSchemaEntities.reversed) {
        await m.drop(entity);
      }

      await m.createAll();
    },
    beforeOpen: (details) async {
      if (details.hadUpgrade || details.wasCreated) await _populateData();
    },
  );

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities {
    final result = super.allSchemaEntities;

    for (final table in result.whereType<TableInfo>().toList()) {
      if (table is !Syncable) continue;

      final name = table.entityName;
      final triggerName = 'syncable_$name';
      final systemColumns = ['last_sync_time', 'timestamp'];
      final updateableColumns = table.columnsByName.keys.whereNot((e) => systemColumns.contains(e));

      result.add(Trigger(
        '''
          CREATE TRIGGER IF NOT EXISTS "$triggerName"
          AFTER UPDATE OF ${updateableColumns.join(',')} ON $name
          BEGIN
            UPDATE $name SET timestamp = CAST(STRFTIME('%s', CURRENT_TIMESTAMP) AS INTEGER) WHERE id = OLD.id;
          END;
        ''',
        triggerName
      ));
    }

    return result;
  }
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

enum BuyerDeliveryMarkType {
  missed,
  arrival,
  departure
}

class OrderLineBarcode {
  int rel;
  String barcode;

  OrderLineBarcode(this.barcode, this.rel);

  factory OrderLineBarcode.fromDart(String value) => OrderLineBarcode(
    value.split('-').first,
    int.parse(value.split('-').last)
  );

  String toDart() => '$barcode-$rel';
}
