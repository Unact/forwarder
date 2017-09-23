import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DbSynch {
  Database db;
  Future<Database> initDB() async {
    // Get a location using path_provider
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = "$dir/forwarder_db.db";
    print ("$path");
    bool isUpgrage;
    do {
      isUpgrage = false;
      // open the database
      db = await openDatabase(path, version: 1,
        onCreate: (Database d, int version) async {
          await d.execute("""
            CREATE TABLE info(
              id INTEGER PRIMARY KEY,
              name TEXT,
              value TEXT,
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )"""
          );
          await d.insert("info", {"name":"server", "value":"https://rapi.unact.ru"});
          await d.insert("info", {"name":"client_id", "value":"forwarder"});
          await d.insert("info", {"name":"login"});
          await d.insert("info", {"name":"password"});
          await d.insert("info", {"name":"token"});
        },
        onUpgrade: (Database database, int oldVersion, int newVersion) async {
          isUpgrage = true;
        },
        onDowngrade: (Database database, int oldVersion, int version) async {
          isUpgrage = true;
        },
      );
      if (isUpgrage) {
        db.close;
        await deleteDatabase(path);
      }
    } while (isUpgrage);
    return db;
  }
}
