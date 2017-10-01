import 'package:flutter/material.dart';
import 'db_synch.dart';

class RepaymentsPage extends StatefulWidget {
  final DbSynch cfg;
  RepaymentsPage({Key key, this.cfg}) : super(key: key);

  @override
  _RepaymentsPageState createState() => new _RepaymentsPageState(cfg: cfg);
}

class _RepaymentsPageState extends State<RepaymentsPage> {
  DbSynch cfg;
  _RepaymentsPageState({this.cfg});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Инкассации")
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text("Инкассации"),
      ),
    );
  }
}
