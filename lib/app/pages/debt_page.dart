import 'package:flutter/material.dart';
import 'package:forwarder/app/pages/card_payment_page.dart';
import 'package:forwarder/app/pages/cash_payment_page.dart';

import 'package:forwarder/app/models/debt.dart';
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

  Future<void> _pay({bool card}) async {
    if (_paymentSum == 0) {
      _showSnackBar('Введена не верная оплата');
      return;
    }

    Map<String, dynamic> result = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => card ?
        CardPaymentPage(debt: widget.debt, paymentSum: _paymentSum) :
        CashPaymentPage(debt: widget.debt, paymentSum: _paymentSum)
    );

    setState(() {
      if (result['success']) {
        _editingEnabled = false;
        _showSnackBar('Оплата успешно создана');
        return;
      }

      _showSnackBar('Произошла ошибка - ${result['errorMessage']}');
    });
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
        _buildPayButtons()
      ]
    );
  }

  Widget _buildPayButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          onPressed: !_editingEnabled ? null : () async {
            await _pay(card: false);
          },
          child: Text('Оплатить нал.', style: TextStyle(color: Colors.white)),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          onPressed: !_editingEnabled ? null : () async {
            await _pay(card: true);
          },
          child: Text('Оплатить безнал.', style: TextStyle(color: Colors.white)),
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
