import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:forwarder/app/pages/card_payment_page.dart';
import 'package:forwarder/app/pages/cash_payment_page.dart';
import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/geo_loc.dart';

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
  TextEditingController _paymentController = TextEditingController();
  double _paymentSum = 0;
  bool _editingEnabled = true;

  Future<void> _pay({bool card}) async {
    List<Debt> debts = [widget.debt];
    Map<String, dynamic> location = await GeoLoc.getCurrentLocation();

    if (_paymentSum == null || _paymentSum <= 0) {
      _showSnackBar('Указана неверная сумма оплаты');
      return;
    }

    if (card && _paymentSum > widget.debt.debtSum) {
      _showSnackBar('Указана неверная сумма для оплаты картой');
      return;
    }

    widget.debt.paymentSum = _paymentSum;

    Map<String, dynamic> result = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => card ?
        CardPaymentPage(debts: debts, location: location) :
        CashPaymentPage(debts: debts, location: location)
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
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      children: <Widget>[
        _buildListViewItem(
          TextFormField(
            enabled: false,
            maxLines: 1,
            style: defaultTextStyle,
            decoration: InputDecoration(
              labelText: 'Накладная',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(),
              prefixIcon: Icon(Icons.assignment)
            ),
            initialValue: widget.debt.fullname,
          )
        ),
        _buildListViewItem(
          TextFormField(
            enabled: false,
            maxLines: 1,
            style: defaultTextStyle,
            decoration: InputDecoration(
              labelText: 'Сумма',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(),
              prefixIcon: Icon(Icons.attach_money)
            ),
            initialValue: Format.numberStr(widget.debt.orderSum)
          )
        ),
        _buildListViewItem(
          TextFormField(
            enabled: false,
            maxLines: 1,
            style: defaultTextStyle,
            decoration: InputDecoration(
              labelText: 'Долг',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(),
              prefixIcon: Icon(Icons.attach_money)
            ),
            initialValue: Format.numberStr(widget.debt.debtSum)
          ),
        ),
        _buildListViewItem(
          TextFormField(
            enabled: false,
            maxLines: 1,
            style: defaultTextStyle,
            decoration: InputDecoration(
              labelText: 'Чек',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(),
              prefixIcon: Icon(Icons.receipt)
            ),
            initialValue: widget.debt.isCheck ? 'Да' : 'Нет'
          )
        ),
        Container(height: 32),
        _buildListViewItem(
          GestureDetector(
            child: TextFormField(
              autofocus: true,
              controller: _paymentController,
              enabled: _editingEnabled,
              maxLines: 1,
              style: defaultTextStyle,
              decoration: InputDecoration(
                labelText: 'Оплата',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              onFieldSubmitted: (String value) {
                String formattedValue = value.replaceAll(',', '.').replaceAll(RegExp(r'\s\b|\b\s'), '');
                double parsedValue;

                try {
                  parsedValue = double.parse(formattedValue);
                } on FormatException {}

                setState(() {
                  if (parsedValue == null || parsedValue <= 0) {
                    _showSnackBar('Введена не верная сумма оплаты');
                  }

                  _paymentSum = parsedValue;
                });
              }
            ),
            onHorizontalDragEnd: (_) {
              setState(() {
                _paymentController.text = Format.numberStr(widget.debt.debtSum);
                _paymentSum = widget.debt.debtSum;
                FocusScope.of(context).unfocus();
              });
            },
          ),
        ),
      ]
    );
  }

  List<Widget> _buildPayButtons() {
    List<Widget> buttons = [
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: !_editingEnabled ? null : () async {
          await _pay(card: false);
        },
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
      )
    ];

    if (Platform.isIOS) {
      buttons.insert(0,
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          onPressed: !_editingEnabled ? null : () async {
            await _pay(card: true);
          },
          child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
        )
      );
    }

    return buttons;
  }

  Widget _buildListViewItem(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: child
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
      body: _buildBody(context),
      persistentFooterButtons: _buildPayButtons()
    );
  }
}
