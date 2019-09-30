import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/database_model.dart';
import 'package:forwarder/app/utils/nullify.dart';

class Repayment extends DatabaseModel {
  static String _tableName = 'repayments';

  int id;
  int buyerId;
  int orderId;
  double summ;
  DateTime ddate;
  bool kkmprinted;

  get tableName => _tableName;

  Repayment({
    Map<String, dynamic> values,
    this.id,
    this.buyerId,
    this.orderId,
    this.summ,
    this.ddate,
    this.kkmprinted
  }) {
    if (values != null) build(values);
  }

  @override
  void build(Map<String, dynamic> values) {
    super.build(values);

    id = values['id'];
    buyerId = values['buyer_id'];
    orderId = values['order_id'];
    summ = Nullify.parseDouble(values['summ']);
    ddate = Nullify.parseDate(values['ddate']);
    kkmprinted = Nullify.parseBool(values['kkmprinted']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['buyer_id'] = buyerId;
    map['order_id'] = orderId;
    map['summ'] = summ;
    map['ddate'] = ddate?.toIso8601String();
    map['kkmprinted'] = kkmprinted;

    return map;
  }

  static Future<List<Repayment>> all() async {
    return (await App.application.data.db.query(_tableName)).map((rec) => Repayment(values: rec)).toList();
  }

  static Future<List<Repayment>> allSorted() async {
    return (await App.application.data.db.rawQuery("""
      select
        repayments.*
      from $_tableName repayments
      join buyers on buyers.id = repayments.buyer_id
      order by buyers.name, buyers.address
    """)).map((rec) => Repayment(values: rec)).toList();
  }

  static Future<void> import(List<dynamic> recs, Batch batch) async {
    batch.delete(_tableName);
    recs.forEach((rec) => batch.insert(_tableName, Repayment(values: rec).toMap()));
  }

  static Future<void> deleteAll() async {
    return await App.application.data.db.delete(_tableName);
  }
}
