import 'package:flutter/material.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/modules/api.dart';
import 'package:forwarder/app/models/debt.dart';

class CashPaymentPage extends StatefulWidget {
  final List<Debt> debts;
  final Map<String, dynamic> location;

  CashPaymentPage({
    this.debts,
    this.location,
    Key key
  }) : super(key: key);

  @override
  _CashPaymentPageState createState() => _CashPaymentPageState();
}

class _CashPaymentPageState extends State<CashPaymentPage> with WidgetsBindingObserver {
  String _status = 'Ожидание';

  @override
  void initState() {
    _savePayment();
    super.initState();
  }


  Future<void> _savePayment() async {
    setState(() {
      _status = 'Сохранение информации об оплате';
    });

    try {
      await Api.post('v1/forwarder/save', data: {
        'payments': widget.debts.map((debt) => {'id': debt.id, 'payment_sum': debt.paymentSum}).toList(),
        'location': widget.location,
        'local_ts': DateTime.now().toIso8601String()
      });
      await App.application.data.dataSync.importData();
      Navigator.pop(context, {
        'success': true
      });
    } on ApiException catch(e) {
      Navigator.pop(context, {
        'success': false,
        'errorMessage': e.errorMsg
      });
    }
  }

  List<Widget> _buildProgressPart() {
    return [
      CircularProgressIndicator(
        backgroundColor: Colors.white70,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      Container(height: 40),
      Text(_status, style: TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      Container(height: 40)
    ];
  }

  List<Widget> _buildInfoPart() {
    return [
      Container(height: 272)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildProgressPart()..addAll(_buildInfoPart())
      )
    );
  }
}
