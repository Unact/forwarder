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
  List<Map> _repayment=[];
  @override
  void initState() {
    super.initState();
    cfg.getRepayment().then((List<Map> list){
      setState((){
        _repayment = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Инкассации")
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: _repayment.map((var a) {
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
                      "${a["kkmprinted"]==1?'чек ':''}",
                      style: new TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    new Text(
                      numFormat.format(a["summ"]),
                      style: new TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )
                    ),
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
