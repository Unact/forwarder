import 'package:flutter/material.dart';
import 'db_synch.dart';
import 'package:sqflite/sqflite.dart';
import 'clients.dart';
import 'repayments.dart';
import 'sorder.dart';
import 'debt.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
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
        sorderRoute: (BuildContext context) => new SorderPage(cfg: cfg),
        debtRoute: (BuildContext context) => new DebtPage(cfg: cfg),
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
  bool sendingClose = false;
  bool sendingInit = false;
  bool sendingConnect = false;
  bool sendingPwd = false;
  bool loading = false;
  DbSynch cfg;
  final TextEditingController _ctlLogin = new TextEditingController();
  final TextEditingController _ctlPwd = new TextEditingController();
  final TextEditingController _ctlSrv = new TextEditingController();
  int _srvVisible = 0;
  @override
  void initState() {
    super.initState();
    loading = true;
    cfg.initDB().then((Database db){
      print('Connected to db!');
      _ctlLogin.text = cfg.login;
      _ctlPwd.text = cfg.password;
      _ctlSrv.text = cfg.server;
      if (cfg.login == null || cfg.login == '' ||
          cfg.password == null || cfg.password == '') {
        _currentIndex = 1;
      }
      cfg.getCnt().then((List<Map> list){
        setState((){
          loading = false;
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
      appBar: new AppBar(
        title: new Text("Маршруты и инкассации")
      ),
      body: _currentIndex==0?(new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushNamed(clientsRoute);
                List<Map> list = await cfg.getCnt();
                setState((){
                  _cntAddresses = list[0]["c"];
                  _cntOrders = list[0]["so"];
                  _cntInc = list[0]["inc"];
                  _sumTotal = list[0]["total"].toDouble();
                  _sumKkm = list[0]["kkm"].toDouble();
                });
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
                            numFormat.format(_sumTotal),
                            style: new TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          new Text(numFormat.format(_sumKkm)),
                        ]
                      ),
                    ]
                  )
                )
            )),
            loading? new LinearProgressIndicator(): new Container(),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: sendingClose? new CircularProgressIndicator() : new RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  setState(()=>sendingClose=true);
                  cfg.putClosed().then((String s){
                    setState(()=>sendingClose=false);
                    var alert;
                    if (s != null) {
                      alert = new AlertDialog(
                        title: new Text("Ошибка закрытия"),
                        content: new Text("$s"),
                      );
                      showDialog(context: context, child: alert);
                      if (s.indexOf('login')>0) {
                        _currentIndex = 1;
                      }
                    }
                    else {
                      setState((){ });
                    }
                  });
                },
                child: new Text(
                  cfg.closed == 1?'Открыть день':'Завершить день',
                  style: new TextStyle(color: Colors.white)
                ),
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: sendingInit? new CircularProgressIndicator(): new RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(()=>sendingInit=true);
                          cfg.fillDB().then((String s) {
                            var alert;
                            setState(()=>sendingInit=false);
                            if (s != null) {
                              alert = new AlertDialog(
                                title: new Text("Ошибка обновления базы"),
                                content: new Text("$s"),
                              );
                              if (s.indexOf('login')>0) {
                                _currentIndex = 1;
                              }
                            }
                            else {
                              cfg.getCnt().then((List<Map> list){
                                setState((){
                                  _cntAddresses = list[0]["c"];
                                  _cntOrders = list[0]["so"];
                                  _cntInc = list[0]["inc"];
                                  _sumTotal = list[0]["total"].toDouble();
                                  _sumKkm = list[0]["kkm"].toDouble();
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
      )):( new Container(
        padding: const EdgeInsets.all(8.0),
        child: new SingleChildScrollView( child: new Column(
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
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: 'Введите пароль',
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ sendingConnect? new CircularProgressIndicator() : new RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(()=>sendingConnect=true);
                          cfg.makeConnection().then((String s) {
                            var alert;
                            setState(()=>sendingConnect=false);
                            if (s != null) {
                              alert = new AlertDialog(
                                title: new Text("Ошибка подключения"),
                                content: new Text("$s"),
                              );
                            }
                            else {
                              _currentIndex = 0;
                              alert = new AlertDialog(
                                title: new Text("Подключение"),
                                content: new Text("Успешно"),
                              );
                            }
                            showDialog(context: context, child: alert);
                          });
                        },
                        child: new Text('Подключиться', style: new TextStyle(color: Colors.white)),
              ),
              sendingPwd? new CircularProgressIndicator() : new RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  setState(()=>sendingPwd=true);
                  cfg.resetPassword().then((String s) {
                    var alert;
                    setState(()=>sendingPwd=false);
                    if (s != null) {
                      alert = new AlertDialog(
                        title: new Text("Ошибка сброса пароля"),
                        content: new Text("$s"),
                      );
                    }
                    else {
                      alert = new AlertDialog(
                        title: new Text("Получение пароля"),
                        content: new Text("Успешно"),
                      );
                    }
                    showDialog(context: context, child: alert);
                  });
                },
                child: new Text('Получить пароль', style: new TextStyle(color: Colors.white)),
              )
            ]
            ),
            ((_srvVisible > 5)?(new TextField(controller: _ctlSrv)):(new Container())),
          ]
        ),)
      )),
      bottomNavigationBar: botNavBar,
    );
  }
}
