import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/card_repayment.dart';
import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/order.dart';
import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/models/repayment.dart';
import 'package:forwarder/app/models/user.dart';
import 'package:forwarder/app/modules/api.dart';

class DataSync {
  DateTime get lastSyncTime {
    String time = App.application.data.prefs.getString('lastSyncTime') ?? '';
    return time != '' ? DateTime.parse(time) : null;
  }
  set lastSyncTime(val) => App.application.data.prefs.setString('lastSyncTime', val.toString());

  Future<void> importData() async {
    await User.currentUser.loadDataFromRemote();

    Map<String, dynamic> data = await Api.get('v2/forwarder');
    Batch batch = App.application.data.db.batch();

    await CardRepayment.import(data['card_repayments'], batch);
    await Buyer.import(data['buyers'], batch);
    await Order.import(data['orders'], batch);
    await Debt.import(data['debts'], batch);
    await Repayment.import(data['repayments'], batch);
    await batch.commit();

    lastSyncTime = DateTime.now();
  }

  Future<void> clearData() async {
    await CardRepayment.deleteAll();
    await Buyer.deleteAll();
    await Order.deleteAll();
    await Debt.deleteAll();
    await Repayment.deleteAll();
    lastSyncTime = '';
  }
}
