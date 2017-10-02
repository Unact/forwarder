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
  //List<Map> _orders=[];

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
            new Text("Инкассация ${_needInc==1?"":"не "}требуется",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            )),
          ],
        )
      ),
    );
  }
}
