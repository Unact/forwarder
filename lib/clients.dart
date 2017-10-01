import 'package:flutter/material.dart';
import 'db_synch.dart';

class ClientsPage extends StatefulWidget {
  final DbSynch cfg;
  ClientsPage({Key key, this.cfg}) : super(key: key);
  @override
  _ClientsPageState createState() => new _ClientsPageState(cfg: cfg);
}

class _ClientsPageState extends State<ClientsPage> {
  DbSynch cfg;
  _ClientsPageState({this.cfg});
  List<Map> _clients=[];
  @override
  void initState() {
    super.initState();
    cfg.getClients().then((List<Map> list){
      setState((){
        _clients = list;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Точки маршрута")
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: _clients.map((var a) {
            return new Column(
              children: [
                new Row(
                  children: [
                    new Expanded(
                      child: new Text(
                        a["name"],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        )
                      )
                    ),
                    new Text(
                      "${a["cnt"]}",
                      style: new TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    new Container(
                      child: new Text(
                        "${a["need_incassation"]==1?' инк':''}",
                        style: new TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      width: 36.0,
                    )
                  ]
                ),
                new Text(
                  a["address"],
                  style: new TextStyle(
                    fontSize: 12.0
                  )
                ),
                new Divider()
              ]);
          }).toList(),
        ),
      ),
    );
  }
}
