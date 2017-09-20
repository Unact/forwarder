import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DbSynch {
  Database db;
  Future<Null> initDB() async {
    // Get a location using path_provider
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = "$dir/forwarder_db.db";
    bool isUpgrage;
    do {
      isUpgrage = false;
      // open the database
      db = await openDatabase(path, version: 2,
        onCreate: (Database database, int version) async {
          await database.execute("""
            CREATE TABLE info(
              id INTEGER PRIMARY KEY,
              name TEXT,
              value TEXT,
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )
            """
          );    
        },
        onUpgrade: (Database database, int oldVersion, int newVersion) async {
          isUpgrage = true;
        }
      );
      if (isUpgrage) {
        db.close;
        await deleteDatabase(path);
      }
    } while (isUpgrage);
  }
}
