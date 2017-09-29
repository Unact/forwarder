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
      db = await openDatabase(path, version: 3,
        onCreate: (Database d, int version) async {
          await d.execute("""
            CREATE TABLE info(
              id INTEGER PRIMARY KEY,
              name TEXT,
              value TEXT,
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )"""
          );
          await d.execute("""
            CREATE TABLE clients(
              id INTEGER,
              partner_id INTEGER,
              name TEXT,
              address TEXT,
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )"""
          );
          await d.execute("""
            CREATE TABLE sale_orders(
              client INTEGER,
              ord INTEGER,
              r_ndoc TEXT,
              so_ndoc TEXT,
              info TEXT,
              goods_cnt INTEGER,
              need_incassation INTEGER,
              mc DECIMAL(18,2),
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )"""
          );
          await d.execute("""
            CREATE TABLE debt(
              client INTEGER,
              partner INTEGER,
              ndoc TEXT,
              ddate DATETIME,
              ischeck INTEGER,
              debt DECIMAL(18,2),
              summ DECIMAL(18,2),              
              ts DATETIME DEFAULT CURRENT_TIMESTAMP
            )"""
          );
          await d.execute("""
            CREATE TABLE repayment(
              repayment_id  INTEGER,
              client_id     INTEGER,
              debt_id       INTEGER,
              summ          DECIMAL(18,2),
              ddate         DATETIME,           
              ts            DATETIME DEFAULT CURRENT_TIMESTAMP
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
    await makeConnection();
    return db;
  }
  
  Future<Null> updateLogin(String s) async {
    login = s.trim();
    await db.execute("UPDATE info SET value = '$login' WHERE name = 'login'");
  }
  
  Future<Null> updatePwd(String s) async {
    password = s.trim();
    await db.execute("UPDATE info SET value = '$password' WHERE name = 'password'");
  }
  
  Future<Null> updateSrv(String s) async {
    server = s.trim();
    await db.execute("UPDATE info SET value = '$server' WHERE name = 'server'");
  }
  
  Future<String> makeConnection() async {
    var httpClient = createHttpClient();
    String url = server + "authenticate";
    var response;
    try {
      response = await httpClient.post(url,
        headers: {"Authorization": "RApi login=$login,client_id=$clientId,password=$password"}
      );
    } catch(exception, stackTrace) {
      return 'Сервер $server недоступен!\n${exception}';
    }
    Map data;
    try {
      data = JSON.decode(response.body);
    } catch(exception, stackTrace) {
      return 'Ответ сервера: ${response.body}\n${exception}';
    }
    token = data["token"];
    await db.execute("UPDATE info SET value = '$token' WHERE name = 'token'");
    return data["error"];
  }
  Future<String> resetPassword() async {
    var httpClient = createHttpClient();
    String url = server + "reset_password";
    var response;
    try {
      response = await httpClient.post(url,
        headers: {"Authorization": "RApi login=$login,client_id=$clientId"}
      );
    } catch(exception, stackTrace) {
      return 'Сервер $server недоступен!\n${exception}';
    }
    Map data;
    try {
      data = JSON.decode(response.body);
    } catch(exception, stackTrace) {
      return 'Ответ сервера: ${response.body}\n${exception}';
    }
    return data["error"];
  }
  
  Future<String> fillDB() async {
    String s;
    int i = 0;
    var data;
    var response;
    
    do {
      if (token==null) {
        s = (await makeConnection());
        if (s != null) {
          return s;
        }
      }
      var httpClient = createHttpClient();
      String url = server + "forwarder";
      try {
        print("url = $url");
        print("RApi client_id=$clientId,token=$token");
        response = await httpClient.get(url,
          headers: {"Authorization": "RApi client_id=$clientId,token=$token"}
        );
      } catch(exception, stackTrace) {
        return 'Сервер $server недоступен!\n${exception}';
      }
      try {
        data = JSON.decode(response.body);
        if (data["error"] != null) {
          if (i == 1) {
            return data["error"];
          }
          token = null;
          i++;
        }
      } catch(exception, stackTrace) {
        return 'Ответ сервера: ${response.body}\n${exception}';
      }
    } while (i == 1);
    
    await db.execute("DELETE FROM clients");
    await db.execute("DELETE FROM sale_orders");
    await db.execute("DELETE FROM debt");
    await db.execute("DELETE FROM repayment WHERE repayment_id IS NOT NULL");
    
    for (var client in data["clients"]) {
      await db.execute("""
        INSERT INTO clients (id, partner_id, name, address)
        VALUES(${client["id"]},
               ${client["partner_id"]},
               '${client["partner_id"]}',
               '${client["address"]}')
      """);
    }
    
    for (var so in data["sale_orders"]) {
      await db.execute("""
        INSERT INTO sale_orders(client, ord, r_ndoc, so_ndoc, info, goods_cnt, mc)
        VALUES(${so["client"]},
               ${so["ord"]},
               '${so["r_ndoc"]}',
               '${so["so_ndoc"]}',
               '${so["info"]}',
               ${so["goods_cnt"]},
               ${so["mc"]})
      """);
    }
    
    for (var debt in data["debt"]) {
      await db.execute("""
        INSERT INTO debt(client, partner, ndoc, ddate, ischeck, debt, summ)
        VALUES(${debt["client"]},
               ${debt["partner"]},
               '${debt["ndoc"]}',
               '${debt["ddate"]}',
               ${debt["ischeck"]},
               ${debt["debt"]},
               ${debt["summ"]})
      """);
    }
    
    for (var r in data["repayment"]) {
      await db.execute("""
        INSERT INTO repayment(repayment_id, client_id, debt_id, summ, ddate)
        VALUES(${r["repayment_id"]},
               ${r["client_id"]},
               ${r["debt_id"]},
               ${r["summ"]},
               '${r["ddate"]}')
      """);
    }
    
    return 'test';
  }
  
}
