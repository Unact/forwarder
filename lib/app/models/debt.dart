import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/database_model.dart';
import 'package:forwarder/app/utils/nullify.dart';
import 'package:forwarder/app/utils/format.dart';

class Debt extends DatabaseModel {
  static String _tableName = 'debts';

  int id;
  int buyerId;
  int orderId;
  String ndoc;
  String orderNdoc;
  DateTime ddate;
  DateTime orderDdate;
  bool isCheck;
  double debtSum;
  double orderSum;
  double paidSum;

  double paymentSum;

  get tableName => _tableName;

  get orderName => orderNdoc + ' от ' + Format.dateStr(orderDdate);
  get fullname => ndoc + ' от ' + Format.dateStr(ddate) + ' (' + orderNdoc + ')';

  Debt({
    Map<String, dynamic> values,
    this.id,
    this.buyerId,
    this.orderId,
    this.ndoc,
    this.orderNdoc,
    this.ddate,
    this.orderDdate,
    this.isCheck,
    this.debtSum,
    this.orderSum,
    this.paidSum
  }) {
    if (values != null) build(values);
  }

  @override
  void build(Map<String, dynamic> values) {
    super.build(values);

    id = values['id'];
    buyerId = values['buyer_id'];
    orderId = values['order_id'];
    ndoc = values['ndoc'];
    orderNdoc = values['order_ndoc'];
    ddate = Nullify.parseDate(values['ddate']);
    orderDdate = Nullify.parseDate(values['order_ddate']);
    isCheck = Nullify.parseBool(values['is_check']);
    debtSum = Nullify.parseDouble(values['debt_sum']);
    orderSum = Nullify.parseDouble(values['order_sum']);
    paidSum = Nullify.parseDouble(values['paid_sum']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['buyer_id'] = buyerId;
    map['order_id'] = orderId;
    map['ndoc'] = ndoc;
    map['order_ndoc'] = orderNdoc;
    map['ddate'] = ddate?.toIso8601String();
    map['order_ddate'] = orderDdate?.toIso8601String();
    map['is_check'] = isCheck;
    map['debt_sum'] = debtSum;
    map['order_sum'] = orderSum;
    map['paid_sum'] = paidSum;

    return map;
  }

  static Future<List<Debt>> all() async {
    return (await App.application.data.db.query(_tableName)).map((rec) => Debt(values: rec)).toList();
  }

  static Future<void> import(List<dynamic> recs, Batch batch) async {
    batch.delete(_tableName);
    recs.forEach((rec) => batch.insert(_tableName, Debt(values: rec).toMap()));
  }

  static Future<void> deleteAll() async {
    return await App.application.data.db.delete(_tableName);
  }
}
