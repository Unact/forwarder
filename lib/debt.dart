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
  double _sum = 0.0;
  double _sumKkm = 0.0;
  double _dx = 0.0;
  int _direction = 1;
  bool sendingSave = false;

  @override
  void initState() {
    super.initState();
    cfg.getDebt().then((List<Map> list){
      _debt = list;
      for (var d in _debt) {
        d["tc"]= new TextEditingController(text: d["r_summ"]==null?null:d["r_summ"].toString());
        d["tc"].addListener(() {
          fillSum();
        });
      }
      fillSum();
    });
  }

  void fillSum(){
    double t1 = 0.0;
    double t2 = 0.0;
    for (var r in _debt) {
      double rSumm;
      String s = r["tc"].text;
      if (s != null && s != "") {
        s = s.replaceFirst('.', ',');
        try{
          rSumm = numFormat.parse(s);
        } catch(exception) {
          rSumm = 0.0;
        }
        t1 += rSumm;
        if (r["ischeck"]==1){
          t2 += rSumm;
        }
      }
      r["r_summ"] = rSumm;
    }
    setState((){
      _sum = t1;
      _sumKkm = t2;
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Expanded( child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      cfg.clientName,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0
                      )
                    ),
                    new Text(
                      "Всего: ${numFormat.format(_sum)}",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0
                      )
                    ),
                    new Text(
                      "Чек: ${numFormat.format(_sumKkm)}",
                      style: new TextStyle(
                        fontSize: 12.0
                      )
                    ),
                  ]
                ),),
                sendingSave? new CircularProgressIndicator() : new RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(()=>sendingSave=true);
                    cfg.saveDb(_debt).then((String s) {
                      var alert;
                      setState(()=>sendingSave=false);
                      if (s != null) {
                        alert = new AlertDialog(
                          title: new Text("Ошибка"),
                          content: new Text("$s"),
                        );
                      }
                      else {
                        alert = new AlertDialog(
                          title: new Text("Сохранение"),
                          content: new Text("Успешно"),
                        );
                      }
                      showDialog(context: context, child: alert);
                    });
                  },
                  child: new Text('Сохранить', style: new TextStyle(color: Colors.white)),
                ),
            ]),
            new Divider(),
            new Expanded(
              child: new ListView(
                children: _debt.map((var a) {
                  return new Column(
                    children: [
                      new GestureDetector(
                        onHorizontalDragUpdate: (DragUpdateDetails details) {
                          if (_dx == 0.0) {
                            _dx = details.globalPosition.dx;
                          } else if (_dx > details.globalPosition.dx) {
                            _direction = -1;
                          } else if (_dx < details.globalPosition.dx) {
                            _direction = 1;
                          }
                        },
                        onHorizontalDragEnd: (_) {
                          _dx = 0.0;
                          if (a["ischeck"] == 0 || a["repayment_id"] == null) {
                            if(_direction == -1){
                              a["tc"].clear();
                            } else if(_direction == 1) {
                              a["tc"].text = a["debt"].toString();
                            }
                          }
                        },
                        child: new Row(
                                children: [
                                  new Expanded(
                                    flex: 20,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        new Text(
                                          "№ ${a["ndoc"]} от ${dateFormat.format(DateTime.parse(a["ddate"]))}",
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                          )
                                        ),
                                        new Wrap(
                                          spacing: 4.0, // gap between adjacent chips
                                          runSpacing: 2.0, // gap between lines
                                          crossAxisAlignment: WrapCrossAlignment.end,
                                          children: [
                                            new Text(
                                              "Сумма:${numFormat.format(a["summ"])} Долг:${numFormat.format(a["debt"])}",
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                              )
                                            ),
                                            ((a["ischeck"]==1)?(new Container(
                                              child: new Text(
                                                "чек!",
                                                style: new TextStyle(
                                                  fontSize: 12.0
                                                )
                                              ),
                                              decoration: new BoxDecoration(
                                                color: Colors.red,
                                                border: new Border.all(
                                                  color: Colors.red,
                                                  width: 2.0,
                                                ),
                                              ),
                                            )):(new Container()))
                                          ]
                                        )
                                    ])
                                  ),
                                  new Expanded(
                                    flex: 10,
                                    child:  (a["ischeck"] == 1 && a["repayment_id"] != null)?
                                      new Text(
                                        a["r_summ"].toString(),
                                        textAlign: TextAlign.right,
                                      ):new TextField(
                                        keyboardType: TextInputType.number,
                                        controller: a["tc"],
                                        textAlign: TextAlign.right,
                                        decoration: new InputDecoration(
                                          hintText: 'Сумма',
                                        ),
                                      ),
                                  )
                                ]
                              ),
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
