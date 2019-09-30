import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:forwarder/config/app_config.dart';
import 'package:forwarder/data/data_sync.dart';

class AppData {
  AppData(AppConfig config) : env = config.env, version = config.databaseVersion;

  final String schemaPath = 'lib/data/schema.sql';
  final String env;
  final int version;
  Database db;
  String dbPath;
  SharedPreferences prefs;
  DataSync dataSync;

  Future<void> setup() async {
    String currentPath = (await getApplicationDocumentsDirectory()).path;

    dbPath = '$currentPath/$env.db';

    await _setupDataStores();
    dataSync = DataSync();

    print('Initialized AppData');
  }

  Future<void> recreateDataStores() async {
    await prefs.clear();
    await deleteDatabase(dbPath);
    await _setupDataStores();
  }

  Future<void> _setupDataStores() async {
    int prevVersion = version;
    List<String> schemaExps = (await rootBundle.loadString(schemaPath)).split(';');
    schemaExps.removeLast(); // Уберем перенос строки

    prefs = await SharedPreferences.getInstance();
    db = await openDatabase(dbPath, version: version,
      onCreate: (Database db, int version) async {
        await Future.wait(schemaExps.map((exp) => db.execute(exp)));
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) => prevVersion = oldVersion,
      onDowngrade: (Database db, int oldVersion, int newVersion) => prevVersion = oldVersion
    );

    if (prevVersion != version) {
      await db.close();
      await recreateDataStores();
    } else {
      print('Started database');
    }
  }
}
