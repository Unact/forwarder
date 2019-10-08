import 'package:flutter/material.dart';

import 'package:forwarder/app/models/card_repayment.dart';
import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/repayment.dart';
import 'package:forwarder/app/utils/format.dart';

class PaymentsPage extends StatefulWidget {
  PaymentsPage({Key key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> with WidgetsBindingObserver {
  List<Buyer> _buyers = [];
  List<Repayment> _repayments = [];
  List<CardRepayment> _cardRepayments = [];

  Future<void> _loadData() async {
    _buyers = await Buyer.all();
    _repayments = await Repayment.allSorted();
    _cardRepayments = await CardRepayment.allSorted();

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          initiallyExpanded: true,
          title: Text('Наличными'),
          children: _repayments.map((repayment) => _repaymentTile(context, repayment)).toList(),
        ),
        ExpansionTile(
          initiallyExpanded: true,
          title: Text('Картой'),
          children: _cardRepayments.map((cardRepayment) => _cardRepaymentTile(context, cardRepayment)).toList(),
        )
      ]
    );
  }

  Widget _cardRepaymentTile(BuildContext context, CardRepayment cardRepayment) {
    Buyer buyer = _buyers.firstWhere((buyer) => buyer.id == cardRepayment.buyerId);
    Color summColor = Colors.red;

    return ListTile(
      dense: true,
      trailing: Text(Format.numberStr(cardRepayment.summ), style: TextStyle(color: summColor)),
      title: Text(buyer.name, style: TextStyle(fontSize: 14.0)),
      subtitle: Text(buyer.address, style: TextStyle(fontSize: 10.0)),
    );
  }

  Widget _repaymentTile(BuildContext context, Repayment repayment) {
    Buyer buyer = _buyers.firstWhere((buyer) => buyer.id == repayment.buyerId);
    Color summColor = repayment.kkmprinted ? Colors.red : Colors.black;

    return ListTile(
      dense: true,
      trailing: Text(Format.numberStr(repayment.summ), style: TextStyle(color: summColor)),
      title: Text(buyer.name, style: TextStyle(fontSize: 14.0)),
      subtitle: Text(buyer.address, style: TextStyle(fontSize: 10.0)),
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
      appBar: AppBar(
        title: Text('Оплаты')
      ),
      body: _buildBody(context)
    );
  }
}
