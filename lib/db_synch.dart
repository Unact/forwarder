import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const String clientsRoute = "/clients";
const String repaymentsRoute = "/repayments";
const String sorderRoute = "/sorder";
const String debtRoute = "/debt";
final numFormat = new NumberFormat("#,##0.00", "ru_RU");
final dateFormat = new DateFormat("dd.MM.yy") ;

class DbSynch {
  Database db;
  String login;
  String password;
  String clientId;
  String server;
  String token;
  int dbClientId=0;
  String clientName="";

  Future<Database> initDB() async {
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
              debt_id INTEGER,
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
              kkmprinted    INTEGER,
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
    } catch(exception) {
      return 'Сервер $server недоступен!\n${exception}';
    }
    Map data;
    try {
      data = JSON.decode(response.body);
    } catch(exception) {
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
    } catch(exception) {
      return 'Сервер $server недоступен!\n${exception}';
    }
    Map data;
    try {
      data = JSON.decode(response.body);
    } catch(exception) {
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
      } catch(exception) {
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
      } catch(exception) {
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
               '${client["name"]}',
               '${client["address"]}')
      """);
    }

    for (var so in data["sale_orders"]) {
      await db.execute("""
        INSERT INTO sale_orders(client, ord, r_ndoc, so_ndoc, info, need_incassation, goods_cnt, mc)
        VALUES(${so["client"]},
               ${so["ord"]},
               '${so["r_ndoc"]}',
               '${so["so_ndoc"]}',
               '${so["info"]}',
               ${so["need_incassation"]},
               ${so["goods_cnt"]},
               ${so["mc"]})
      """);
    }

    for (var debt in data["debt"]) {
      await db.execute("""
        INSERT INTO debt(client, partner, debt_id, ndoc, ddate, ischeck, debt, summ)
        VALUES(${debt["client"]},
               ${debt["partner"]},
               ${debt["debt_id"]},
               '${debt["ndoc"]}',
               '${debt["ddate"]}',
               ${debt["ischeck"]},
               ${debt["debt"]},
               ${debt["summ"]})
      """);
    }

    for (var r in data["repayment"]) {
      await db.execute("""
        INSERT INTO repayment(repayment_id, client_id, debt_id, summ, ddate, kkmprinted)
        VALUES(${r["repayment_id"]},
               ${r["client_id"]},
               ${r["debt_id"]},
               ${r["summ"]},
               '${r["ddate"]}',
               ${r["kkmprinted"]})
      """);
    }
    return null;
  }

  Future<List<Map>> getCnt() async {
    List<Map> list;
    list = await db.rawQuery("""
        SELECT
          (SELECT COUNT(*)  FROM clients) c,
          (SELECT COUNT(*)  FROM sale_orders) so,
          (SELECT COUNT(*)  FROM sale_orders WHERE  need_incassation = 1) +
          (SELECT COUNT(*)  FROM clients WHERE id NOT IN
          (SELECT client FROM sale_orders)
          )  inc,
          IFNULL((SELECT sum(summ)  FROM repayment),0.0) total,
          IFNULL((SELECT sum(summ)  FROM repayment WHERE kkmprinted = 1),0.0) kkm
        """);
    return list;
  }

  Future<List<Map>> getClients() async {
    List<Map> list;
    list = await db.rawQuery("""
      select
        id, name, address,
        ifnull((select min(ord) from sale_orders so where so.client = c.id),999) ord,
        (select count(*) from sale_orders so where so.client = c.id) cnt,
        case when ((select count(*) from sale_orders so where so.client = c.id
                    and need_incassation=1)>0 or
                   (select count(*) from sale_orders so where so.client = c.id) = 0) then 1
        else 0
        end need_incassation
     from clients c
     order by ord, name,address,id
    """);
    return list;
  }

  Future<List<Map>> getRepayment() async {
    List<Map> list;
    list = await db.rawQuery("""
      select
        c.name,
        c.address,
        r.summ,
        r.kkmprinted
     from repayment r
          left outer join clients c on r.client_id = c.id
     order by 1, 2
    """);
    return list;
  }
  Future<List<Map>> getClient() async {
    List<Map> list;
    list = await db.rawQuery("""
      select
            c.name,
            c.address,
            ifnull((select sum(debt) from debt where client=c.id),0.0) debt,
    		ifnull((select sum(summ) from repayment where client_id=c.id),0.0) inc,
    		case when ((select count(*) from sale_orders so where so.client = c.id
                        and need_incassation=1)>0 or
                       (select count(*) from sale_orders so where so.client = c.id) = 0) then 1
            else 0
            end need_incassation
         from clients c where c.id=${dbClientId}
         order by 1, 2
      """);
    return list;
  }

  Future<List<Map>> getSorders() async {
    List<Map> list;
    list = await db.rawQuery("""
      select
        so_ndoc,
        info,
        mc,
        goods_cnt
      from
        sale_orders
      where
        client=${dbClientId}
      order by 1, 2
      """);
      return list;
  }

  Future<List<Map>> getDebt() async {
    List<Map> list;
    list = await db.rawQuery("""
      select
        d.debt_id, d.ndoc, d.ddate, d.summ, d.debt, d.ischeck, r.summ r_summ, r.repayment_id
      from
        debt d
        left outer join repayment r on r.debt_id = d.debt_id
      where
        d.client=${dbClientId}
      order by 3 DESC, 2 DESC
      """);
      return list;
  }

  Future<String> saveDb(List<Map> debt) async {
    String res;
    for (var d in debt){
      List<Map> r = await db.rawQuery("select debt_id from repayment where debt_id=${d["debt_id"]}");

      if (r.length == 0 && d["r_summ"] != null) {
        await db.execute("""
          INSERT INTO repayment(client_id, debt_id, summ, ddate, kkmprinted)
          VALUES(${dbClientId},
                 ${d["debt_id"]},
                 ${d["r_summ"]},
                 '${new DateTime.now()}',
                 ${d["ischeck"]})
        """);
      } else if (r.length > 0) {
        await db.execute("UPDATE repayment SET summ = ${d["r_summ"]} WHERE debt_id=${d["debt_id"]}");
      }
    }
    res = await synchDB();
    return res;
  }

  Future<String> synchDB() async {
    String s;
    int i = 0;
    var data;
    var response;
    List<Map> list;

    list = await db.rawQuery("select * from repayment r");

    do {
      if (token==null) {
        s = (await makeConnection());
        if (s != null) {
          return s;
        }
      }
      var httpClient = createHttpClient();
      String url = server + "forwarder/save";
      try {
        print("url = $url");
        print("RApi client_id=$clientId,token=$token");
        response = await httpClient.post(url,
          headers: {"Authorization": "RApi client_id=$clientId,token=$token",
                    "Accept": "application/json", "Content-Type": "application/json"},
          body: JSON.encode(list)
        );
      } catch(exception) {
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
      } catch(exception) {
        return 'Ответ сервера: ${response.body}\n${exception}';
      }
    } while (i == 1);
    return null;
  }

}
