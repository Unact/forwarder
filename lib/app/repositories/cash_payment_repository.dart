import 'dart:async';

import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';


class CashPaymentRepository {
  final Storage storage;
  final String _tableName = 'cashPayments';

  CashPaymentRepository({@required this.storage});

  Future<List<CashPayment>> getCashPayments() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => CashPayment.fromJson(e)).toList();
  }

  Future<void> addCashPayments(List<CashPayment> payments) async {
    Batch batch = storage.db.batch();
    await Future.wait(payments.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteCashPayments() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadCashPayments(List<CashPayment> payments) async {
    await deleteCashPayments();
    await addCashPayments(payments);
  }
}
