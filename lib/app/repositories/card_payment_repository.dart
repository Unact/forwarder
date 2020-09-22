import 'dart:async';

import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';


class CardPaymentRepository {
  final Storage storage;
  final String _tableName = 'cardPayments';

  CardPaymentRepository({@required this.storage});

  Future<List<CardPayment>> getCardPayments() async {
    return (await storage.db.query(_tableName, orderBy: 'id')).map((e) => CardPayment.fromJson(e)).toList();
  }

  Future<void> addCardPayments(List<CardPayment> payments) async {
    Batch batch = storage.db.batch();
    await Future.wait(payments.map((e) async => await storage.db.insert(_tableName, e.toJson())));
    await batch.commit(noResult: true);
  }

  Future<void> deleteCardPayments() async {
    await storage.db.delete(_tableName);
  }

  Future<void> reloadCardPayments(List<CardPayment> payments) async {
    await deleteCardPayments();
    await addCardPayments(payments);
  }

  Future<void> updateCardPayment(CardPayment cardPayment) async {
    await storage.db.update(_tableName, cardPayment.toJson(), where: 'id = ${cardPayment.id}');
  }
}
