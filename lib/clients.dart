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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Точки маршрута")
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text("Маршрут"),
      ),
    );
  }
}
