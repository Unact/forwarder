import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DbSynch {
  Database db;
  String login;
  String password;
  String clientId;
  String server;
  String token;
  
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
          await d.insert("info", {"name":"server", "value":"https://rapi.unact.ru/api/v1/"});
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

    List<Map> list = await db.rawQuery("""
      select (select value from info where name = 'login') login,
             (select value from info where name = 'password') password,
             (select value from info where name = 'client_id') client_id,
             (select value from info where name = 'server') server,
             (select value from info where name = 'token') token
    """);
    login = list[0]['login'];
    password = list[0]['password'];
    clientId = list[0]['client_id'];
    server = list[0]['server'];
    token = list[0]['token'];
    return db;
  }
  
  Future<Null> updateLogin(String s) async {
    login = s;
    await db.execute("UPDATE info SET value = '$login' WHERE name = 'login'");
  }
  
  Future<Null> updatePwd(String s) async {
    password = s;
    await db.execute("UPDATE info SET value = '$password' WHERE name = 'password'");
  }
  
  Future<String> makeConnection() async {
    var httpClient = createHttpClient();
    String url = server + "authenticate";
    var response = await httpClient.post(url,
      headers: {"Authorization": "RApi login=$login,client_id=$clientId,password=$password"}
    );
    Map data = JSON.decode(response.body);
    token = data["token"];
    await db.execute("UPDATE info SET value = '$token' WHERE name = 'token'");
    return data["error"];
  }
  Future<String> resetPassword() async {
    var httpClient = createHttpClient();
    String url = server + "reset_password";
    var response = await httpClient.post(url,
      headers: {"Authorization": "RApi login=$login,client_id=$clientId"}
    );
    Map data = JSON.decode(response.body);
    return data["error"];
  }
}
