import 'package:flutter/material.dart';
import 'db_synch.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'clients.dart';
import 'repayments.dart';

final numFormat = new NumberFormat("#,##0.00", "ru_RU");
const String clientsRoute = "/clients";
const String repaymentsRoute = "/repayments";

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DbSynch cfg = new DbSynch();
  var routes;
  @override
  void initState() {
    super.initState();
    routes = <String, WidgetBuilder>{
        clientsRoute: (BuildContext context) => new ClientsPage(cfg: cfg),
        repaymentsRoute: (BuildContext context) => new RepaymentsPage(cfg: cfg),
    };
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Экспедитор',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(cfg: cfg),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.cfg}) : super(key: key);
  final DbSynch cfg;
  @override
  _MyHomePageState createState() => new _MyHomePageState(cfg: cfg);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.cfg});
  int _currentIndex = 0;
  int _cntAddresses = 0;
  int _cntOrders = 0;
  int _cntInc = 0;
  double _sumTotal = 0.0;
  double _sumKkm = 0.0;
  DbSynch cfg;
  final TextEditingController _ctlLogin = new TextEditingController();
  final TextEditingController _ctlPwd = new TextEditingController();
  final TextEditingController _ctlSrv = new TextEditingController();
  int _srvVisible = 0;
  @override
  void initState() {
    super.initState();
    cfg.initDB().then((Database db){
      print('Connected to db!');
      _ctlLogin.text = cfg.login;
      _ctlPwd.text = cfg.password;
      _ctlSrv.text = cfg.server;
      cfg.getCnt().then((List<Map> list){
        setState((){
          _cntAddresses = list[0]["c"];
          _cntOrders = list[0]["so"];
          _cntInc = list[0]["inc"];
          _sumTotal = list[0]["total"].toDouble();
          _sumKkm = list[0]["kkm"].toDouble();
        });
      });
    });
    _ctlLogin.addListener(() {
      cfg.updateLogin(_ctlLogin.text);
    });
    _ctlPwd.addListener(() {
      cfg.updatePwd(_ctlPwd.text);
    });
    _ctlSrv.addListener(() {
      cfg.updateSrv(_ctlSrv.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: [new BottomNavigationBarItem(
                    icon: const Icon(Icons.airline_seat_recline_extra),
                    title: const Text('Доставка'),
                    backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(
                    icon: const Icon(Icons.account_box),
                    title: const Text('Настройки'),
                    backgroundColor: Theme.of(context).primaryColor,
              ),
      ],
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
    return new Scaffold(
      body: new Stack(
          children: [
            new Offstage(
              offstage: _currentIndex != 0,
              child: new TickerMode(
                enabled: _currentIndex == 0,
                child: new Scaffold(
                  appBar: new AppBar(
                    title: new Text("Маршруты и инкассации")
                  ),
                  body: new Container(
                    padding: const EdgeInsets.all(16.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(clientsRoute);
                          },
                          child: new Card(
                          child: new Container(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row (
                              children: [ new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text("Маршрут"),
                                  new Text(
                                    "Адресов: $_cntAddresses",
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                    ),
                                  ),
                                  new Text("Заказов: $_cntOrders Инкассаций: $_cntInc"),
                                ]
                              )
                            ])
                          )
                        )),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(repaymentsRoute);
                          },
                          child: new Card(
                          child:
                            new Container(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                children: [
                                  new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Инкассации"),
                                      new Text(
                                        "Всего:",
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0
                                        ),
                                      ),
                                      new Text("по ККМ:"),
                                    ]
                                  ),
                                  new Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      new Text(" "),
                                      new Text(
                                        "${numFormat.format(_sumTotal)}",
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      new Text("${numFormat.format(_sumKkm)}"),
                                    ]
                                  ),
                                ]
                              )
                            )
                        )),
                        new Container(
                          padding: const EdgeInsets.all(16.0),
                          child: new RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      cfg.fillDB().then((String s) {
                                        var alert;
                                        if (s != null) {
                                          alert = new AlertDialog(
                                            title: new Text("Ошибка обновления базы"),
                                            content: new Text("$s"),
                                          );
                                        }
                                        else {
                                          cfg.getCnt().then((List<Map> list){
                                            setState((){
                                              _cntAddresses = list[0]["c"];
                                              _cntOrders = list[0]["so"];
                                              _cntInc = list[0]["inc"];
                                              _sumTotal = list[0]["total"].toDouble();
                                              _sumKkm = list[0]["kkm"].toDouble();;
                                            });
                                          });
                                          alert = new AlertDialog(
                                            title: new Text("Обновление базы"),
                                            content: new Text("Успешно!"),
                                          );
                                        }
                                        showDialog(context: context, child: alert);
                                      });
                                    },
                                    child: new Text('Обновить', style: new TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            new Offstage(
              offstage: _currentIndex != 1,
              child: new TickerMode(
                enabled: _currentIndex == 1,
                child: new Scaffold(
                  appBar: new AppBar(
                    title: new Text("Настройки подключения")
                  ),
                  body: new Container(
                    padding: const EdgeInsets.all(32.0),
                    child: new Column(
                      children: [
                        new GestureDetector(
                          onTap: () {
                            setState(() { _srvVisible++; });
                          },
                          child: new Text('Телефон или e-mail или имя'),
                        ),
                        new TextField(
                          controller: _ctlLogin,
                          decoration: new InputDecoration(
                            hintText: 'Введите телефон или e-mail или имя',
                          ),
                        ),
                        new Text('Пароль'),
                        new TextField(
                          controller: _ctlPwd,
                          decoration: new InputDecoration(
                            hintText: 'Введите пароль',
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.all(16.0),
                          child: new RaisedButton(
                                    onPressed: () {
                                      cfg.makeConnection().then((String s) {
                                        var alert;
                                        if (s != null) {
                                          alert = new AlertDialog(
                                            title: new Text("Ошибка подключения"),
                                            content: new Text("$s"),
                                          );
                                        }
                                        else {
                                          alert = new AlertDialog(
                                            title: new Text("Подключение"),
                                            content: new Text("Успешно"),
                                          );
                                        }
                                        showDialog(context: context, child: alert);
                                      });
                                    },
                                    child: new Text('Подключиться'),
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.all(16.0),
                          child: new RaisedButton(
                            onPressed: () {
                              cfg.resetPassword().then((String s) {
                                var alert;
                                if (s != null) {
                                  alert = new AlertDialog(
                                    title: new Text("Ошибка сброса пароля"),
                                    content: new Text("$s"),
                                  );
                                }
                                else {
                                  alert = new AlertDialog(
                                    title: new Text("Сброс пароля"),
                                    content: new Text("Успешно"),
                                  );
                                }
                                showDialog(context: context, child: alert);
                              });
                            },
                            child: new Text('Сброс пароля'),
                          ),
                        ),
                        ((_srvVisible > 5)?(new TextField(controller: _ctlSrv)):(new Container())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
