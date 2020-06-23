import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/database_model.dart';
import 'package:forwarder/app/utils/nullify.dart';

class Order extends DatabaseModel {
  static String _tableName = 'orders';

  int id;
  int buyerId;
  int ord;
  String ndoc;
  String info;
  bool inc;
  int goodsCnt;
  double mc;
  bool delivered;

  get tableName => _tableName;

  Order({
    Map<String, dynamic> values,
    this.id,
    this.buyerId,
    this.ord,
    this.ndoc,
    this.info,
    this.inc,
    this.goodsCnt,
    this.mc,
    this.delivered
  }) {
    if (values != null) build(values);
  }

  @override
  void build(Map<String, dynamic> values) {
    super.build(values);

    id = values['id'];
    buyerId = values['buyer_id'];
    ord = values['ord'];
    ndoc = values['ndoc'];
    info = values['info'];
    inc = Nullify.parseBool(values['inc']);
    goodsCnt = values['goods_cnt'];
    mc = Nullify.parseDouble(values['mc']);
    delivered = Nullify.parseBool(values['delivered']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['buyer_id'] = buyerId;
    map['ord'] = ord;
    map['ndoc'] = ndoc;
    map['info'] = info;
    map['inc'] = inc;
    map['goods_cnt'] = goodsCnt;
    map['mc'] = mc;
    map['delivered'] = delivered;

    return map;
  }

  static Future<List<Order>> all() async {
    return (await App.application.data.db.query(_tableName)).map((rec) => Order(values: rec)).toList();
  }

  static Future<void> import(List<dynamic> recs, Batch batch) async {
    batch.delete(_tableName);
    recs.forEach((rec) => batch.insert(_tableName, Order(values: rec).toMap()));
  }

  static Future<void> deleteAll() async {
    return await App.application.data.db.delete(_tableName);
  }
}
