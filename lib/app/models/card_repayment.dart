import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/database_model.dart';
import 'package:forwarder/app/utils/nullify.dart';

class CardRepayment extends DatabaseModel {
  static String _tableName = 'card_repayments';

  int id;
  int buyerId;
  int orderId;
  double summ;
  DateTime ddate;

  get tableName => _tableName;

  CardRepayment({
    Map<String, dynamic> values,
    this.id,
    this.buyerId,
    this.orderId,
    this.summ,
    this.ddate
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
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['buyer_id'] = buyerId;
    map['order_id'] = orderId;
    map['summ'] = summ;
    map['ddate'] = ddate?.toIso8601String();

    return map;
  }

  static Future<List<CardRepayment>> all() async {
    return (await App.application.data.db.query(_tableName)).map((rec) => CardRepayment(values: rec)).toList();
  }

  static Future<List<CardRepayment>> allSorted() async {
    return (await App.application.data.db.rawQuery("""
      select
        card_repayments.*
      from $_tableName card_repayments
      join buyers on buyers.id = card_repayments.buyer_id
      order by buyers.name, buyers.address
    """)).map((rec) => CardRepayment(values: rec)).toList();
  }

  static Future<void> import(List<dynamic> recs, Batch batch) async {
    batch.delete(_tableName);
    recs.forEach((rec) => batch.insert(_tableName, CardRepayment(values: rec).toMap()));
  }

  static Future<void> deleteAll() async {
    return await App.application.data.db.delete(_tableName);
  }
}
