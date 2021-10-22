import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';

class BuyerRepository {
  final Storage storage;
  final String _tableName = 'buyers';

  BuyerRepository({required this.storage});

  Future<List<Buyer>> getBuyers() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => Buyer.fromJson(e)).toList();
  }

  Future<void> addBuyers(List<Buyer> buyers) async {
    Batch batch = storage.db.batch();
    await Future.wait(buyers.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteBuyers() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadBuyers(List<Buyer> buyers) async {
    await deleteBuyers();
    await addBuyers(buyers);
  }
}
