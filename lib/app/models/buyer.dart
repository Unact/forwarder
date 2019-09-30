import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/database_model.dart';

class Buyer extends DatabaseModel {
  static String _tableName = 'buyers';

  int id;
  String name;
  String address;

  bool inc;

  get tableName => _tableName;

  Buyer({Map<String, dynamic> values, this.id, this.name, this.address}) {
    if (values != null) build(values);
  }

  @override
  void build(Map<String, dynamic> values) {
    super.build(values);

    id = values['id'];
    name = values['name'];
    address = values['address'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;

    return map;
  }

  static Future<List<Buyer>> all() async {
    return (await App.application.data.db.query(_tableName)).map((rec) => Buyer(values: rec)).toList();
  }

  static Future<void> import(List<dynamic> recs, Batch batch) async {
    batch.delete(_tableName);
    recs.forEach((rec) => batch.insert(_tableName, Buyer(values: rec).toMap()));
  }

  static Future<void> deleteAll() async {
    return await App.application.data.db.delete(_tableName);
  }

  static Future<List<Buyer>> allSorted() async {
    return (await App.application.data.db.rawQuery("""
      select
        buyers.*,
        ifnull((select min(ord) from orders where orders.buyer_id = buyers.id), 999) ord
      from $_tableName buyers
      order by ord, buyers.name, buyers.address
    """)).map((rec) => Buyer(values: rec)).toList();
  }
}
