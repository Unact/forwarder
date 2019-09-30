import 'package:flutter/material.dart';
import 'package:forwarder/app/app.dart';

import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/modules/api.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';

class DebtPage extends StatefulWidget {
  final Debt debt;

  DebtPage({Key key, @required this.debt}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle firstColumnTextStyle = TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
  double _paymentSum = 0;
  bool _editingEnabled = true;

  void _pay() async {
    if (_paymentSum == 0) {
      _showSnackBar('Введена не верная оплата');
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(child: CircularProgressIndicator())
      );

      await Api.post('v2/forwarder/save', body: {
        'id': widget.debt.id,
        'payment_sum': _paymentSum,
        'local_ts': DateTime.now().toIso8601String()
      });
      await App.application.data.dataSync.importData();

      setState(() {
        _editingEnabled = false;
        Navigator.pop(context);
        _showSnackBar('Оплата успешно создана');
      });
    } on ApiException catch(e) {
      Navigator.pop(context);
      _showSnackBar(e.errorMsg);
    }
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  void _loadData() {
    _paymentSum = widget.debt.debtSum;

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Text('Накладная', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, height: 24.0/15.0))
        ),
        _buildListViewItem(_buildTable()),
        _buildPayButton(),
      ]
    );
  }

  Widget _buildPayButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.red,
          onPressed: _editingEnabled ? _pay : null,
          child: Text('Оплатить нал.', style: TextStyle(color: Colors.white)),
        ),
      ]
    );
  }

  Widget _buildListViewItem(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: child
    );
  }

  Table _buildTable() {
    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(96.0),
      },
      children: <TableRow>[
        _buildTableRow('', widget.debt.name.toString()),
        _buildTableRow('Сумма', Format.numberStr(widget.debt.orderSum)),
        _buildTableRow('Долг', Format.numberStr(widget.debt.debtSum)),
        _buildTableRow('Чек', widget.debt.isCheck ? 'Да' : 'Нет'),
        TableRow(
          children: <Widget>[
            Padding(
              padding: firstColumnPadding,
              child: Text('Оплата', style: firstColumnTextStyle, textAlign: TextAlign.end)
            ),
            Padding(
              padding: baseColumnPadding,
              child: TextFormField(
                enabled: _editingEnabled,
                maxLines: 1,
                keyboardType: TextInputType.number,
                initialValue: _paymentSum.toStringAsFixed(2),
                style: defaultTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(),
                ),
                onChanged: (String value) {
                  _paymentSum = Nullify.parseDouble(value) ?? 0;
                }
              ),
            ),
          ]
        )
      ]
    );
  }

  TableRow _buildTableRow(String leftStr, String rightStr) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: firstColumnPadding,
          child: Text(leftStr, style: firstColumnTextStyle, textAlign: TextAlign.end)
        ),
        Padding(
          padding: baseColumnPadding,
          child: Text(rightStr)
        ),
      ]
    );
  }

  @override
  void initState() {

    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Задолженность')
      ),
      body: _buildBody(context)
    );
  }
}
