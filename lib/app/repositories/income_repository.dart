import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';

class IncomeRepository {
  final Storage storage;
  final String _tableName = 'incomes';

  IncomeRepository({required this.storage});

  Future<List<Income>> getIncomes() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => Income.fromJson(e)).toList();
  }

  Future<void> addIncomes(List<Income> incomes) async {
    Batch batch = storage.db.batch();
    await Future.wait(incomes.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteIncomes() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadIncomes(List<Income> incomes) async {
    await deleteIncomes();
    await addIncomes(incomes);
  }
}
