import 'package:flutter/material.dart';

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

  Future<void> _loadData() async {
    _buyers = await Buyer.all();
    _repayments = await Repayment.allSorted();

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: _repayments.map((repayment) => _repaymentTile(context, repayment)).toList());
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
