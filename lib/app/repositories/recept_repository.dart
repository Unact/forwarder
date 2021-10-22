import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';

class ReceptRepository {
  final Storage storage;
  final String _tableName = 'recepts';

  ReceptRepository({required this.storage});

  Future<List<Recept>> getRecepts() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => Recept.fromJson(e)).toList();
  }

  Future<void> addRecepts(List<Recept> recepts) async {
    Batch batch = storage.db.batch();
    await Future.wait(recepts.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteRecepts() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadRecepts(List<Recept> recepts) async {
    await deleteRecepts();
    await addRecepts(recepts);
  }
}
