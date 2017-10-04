import 'package:flutter/material.dart';
import 'db_synch.dart';

class DebtPage extends StatefulWidget {
  final DbSynch cfg;
  DebtPage({Key key, this.cfg}) : super(key: key);
  @override
  _DebtPageState createState() => new _DebtPageState(cfg: cfg);
}

class _DebtPageState extends State<DebtPage> {
  DbSynch cfg;
  _DebtPageState({this.cfg});
  List<Map> _debt=[];
  @override
  void initState() {
    super.initState();
    cfg.getDebt().then((List<Map> list){
      setState((){
        _debt = list;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Оплаты")
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              cfg.clientName,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              )
            ),
            new Divider(),
            new Text(
              "Всего: ${numFormat.format(0.0)} Чек: ${numFormat.format(0.0)}",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              )
            ),
            new Divider(),
            new Expanded(
              child: new ListView(
                children: _debt.map((var a) {
                  return new Column(
                    children: [
                      new Row(
                                children: [
                                  new Expanded(
                                    flex: 20,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        new Text(
                                          "№ ${a["ndoc"]} от ${dateFormat.format(DateTime.parse(a["ddate"]))}",
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                          )
                                        ),
                                        new Wrap(
                                          spacing: 4.0, // gap between adjacent chips
                                          runSpacing: 2.0, // gap between lines
                                          children: [
                                            new Text(
                                              "Сумма: ${numFormat.format(a["summ"])} Долг: ${numFormat.format(a["debt"])}",
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                              )
                                            ),
                                            new Text(
                                              "чек!",
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                              )
                                            )
                                          ]
                                        )
                                    ])
                                  ),
                                  new Expanded(
                                    flex: 10,
                                    child: new TextField(
                                      decoration: new InputDecoration(
                                        hintText: 'Сумма',
                                      ),
                                    ),
                                  )
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
