import 'dart:async';

import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';


class DebtRepository {
  final Storage storage;
  final String _tableName = 'debts';

  DebtRepository({@required this.storage});

  Future<List<Debt>> getDebts() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => Debt.fromJson(e)).toList();
  }

  Future<void> addDebts(List<Debt> debts) async {
    Batch batch = storage.db.batch();
    await Future.wait(debts.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteDebts() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadDebts(List<Debt> debts) async {
    await deleteDebts();
    await addDebts(debts);
  }

  Future<void> updateDebt(Debt debt) async {
    await storage.db.update(_tableName, debt.toJson(), where: 'id = ${debt.id}');
  }
}
