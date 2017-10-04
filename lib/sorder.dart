import 'package:flutter/material.dart';
import 'db_synch.dart';

class SorderPage extends StatefulWidget {
  final DbSynch cfg;
  SorderPage({Key key, this.cfg}) : super(key: key);
  @override
  _SorderPageState createState() => new _SorderPageState(cfg: cfg);
}

class _SorderPageState extends State<SorderPage> {
  DbSynch cfg;
  String _clientName="";
  String _clientAddress="";
  double _debt=0.0;
  double _inc=0.0;
  int _needInc=0;
  List<Map> _orders=[];

  _SorderPageState({this.cfg});
  @override
  void initState() {
    super.initState();
    cfg.getClient().then((List<Map> list){
      setState((){
        _clientName=list[0]["name"];
        _clientAddress=list[0]["address"];
        _debt=list[0]["debt"].toDouble();
        _inc=list[0]["inc"].toDouble();
        _needInc=list[0]["need_incassation"];
      });
    });
    cfg.getSorders().then((List<Map> list){
      setState((){
        _orders = list;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Точка маршрута")
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              _clientName,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              )
            ),
            new Divider(),
            new Text(_clientAddress),
            new Divider(),
            new Text("Долг: ${numFormat.format(_debt)} Получено: ${numFormat.format(_inc)}"),
            new Divider(),
            new GestureDetector(
              onTap: () async {
                bool isSave = await Navigator.of(context).pushNamed(debtRoute);
                if (isSave == true){
                  List<Map> list = await cfg.getClient();
                  setState((){
                    _inc=list[0]["inc"].toDouble();
                  });
                }
              },
              child: new Container(
                alignment: FractionalOffset.center,
                child: new Text(
                _needInc==1?"Требуется инкассация":"Инкассация не требуется",
                style: new TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
              ))),
            ),
            new Divider(),
            new Text("Заказы"),
            new Text(" ", style: new TextStyle(fontSize: 6.0)),
            new Row(
              children: [
                new Expanded(
                  flex: 18,
                  child: new Text(
                    "Номер",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),
                new Expanded(
                  flex: 50,
                  child: new Text(
                    "Комментарий",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0
                    )
                  )
                ),
                new Expanded(
                  flex: 13,
                  child: new Text(
                    "Кор.",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),
                new Expanded(
                  flex: 13,
                  child: new Text(
                    "Тов.",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ]
            ),
            new Divider(),
            new Expanded(
              child: new ListView(
                children: _orders.map((var a) {
                  return new Column(
                    children: [
                      new Row(
                                children: [
                                  new Expanded(
                                    flex: 18,
                                    child: new Text(
                                      a["so_ndoc"],
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                      )
                                    )
                                  ),
                                  new Expanded(
                                    flex: 50,
                                    child: new Text(
                                      a["info"],
                                      style: new TextStyle(
                                        fontSize: 12.0
                                      )
                                    )
                                  ),
                                  new Expanded(
                                    flex: 13,
                                    child: new Text(
                                      numFormat.format(a["mc"]),
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                      )
                                    )
                                  ),
                                  new Expanded(
                                    flex: 13,
                                    child: new Text(
                                      a["goods_cnt"].toString(),
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                      )
                                    ),
                                  ),
                                ]
                              ),
                              new Divider(),
                            ]);
                }).toList()
              )
            )
          ],
        )
      ),
    );
  }
}
