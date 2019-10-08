import 'dart:async';

import 'package:flutter/material.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/card_repayment.dart';
import 'package:forwarder/app/models/order.dart';
import 'package:forwarder/app/models/repayment.dart';
import 'package:forwarder/app/models/user.dart';
import 'package:forwarder/app/modules/api.dart';
import 'package:forwarder/app/pages/person_page.dart';
import 'package:forwarder/app/utils/format.dart';

class InfoPage extends StatefulWidget {
  final GlobalKey bottomNavigationBarKey;
  InfoPage({Key key, @required this.bottomNavigationBarKey}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List<Buyer> _buyers = [];
  List<Order> _orders = [];
  List<Repayment> _repayments = [];
  List<CardRepayment> _cardRepayments = [];

  Future<void> _loadData() async {
    _cardRepayments = await CardRepayment.all();
    _repayments = await Repayment.all();
    _buyers = await Buyer.all();
    _orders = await Order.all();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _syncData() async {
    try {
      await App.application.data.dataSync.importData();
      await _loadData();
    } on ApiException catch(e) {
      _showErrorSnackBar(e.errorMsg);
    }
  }

  Future<void> _onReverseDay() async {
    User user = User.currentUser;
    bool closed = user.closed;
    String msg = 'День успешно ${closed ? 'открыт' : 'закрыт'}';

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(child: CircularProgressIndicator())
      );

      await user.reverseDay();
    } on ApiException catch(e) {
      msg = e.errorMsg;
    }

    Navigator.pop(context);
    _showSnackBar(msg);
    setState(() {});
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  void _showErrorSnackBar(String content) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'Повторить',
        onPressed: _refreshIndicatorKey.currentState?.show
      )
    ));
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    return <Widget>[
      Card(
        child: ListTile(
          onTap: () {
            BottomNavigationBar navigationBar = widget.bottomNavigationBarKey.currentWidget;
            navigationBar.onTap(1);
          },
          isThreeLine: true,
          title: Text('Точки'),
          subtitle: _buildPointsSubtitle(),
          trailing: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Text('${User.currentUser.closed ? 'Открыть' : 'Закрыть'} день'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: _onReverseDay
          ),
        ),
      ),
      Card(
        child: ListTile(
          onTap: () {
            BottomNavigationBar navigationBar = widget.bottomNavigationBarKey.currentWidget;
            navigationBar.onTap(2);
          },
          isThreeLine: true,
          title: Text('Оплаты'),
          subtitle: _buildPaymentsSubtitle(),
        ),
      )
    ];
  }

  Widget _buildPointsSubtitle() {
    int incassations = _orders.where((order) => order.inc).length +
      _buyers.where((buyer) => !_orders.any((order) => order.buyerId == buyer.id)).length;

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(text: 'Адресов: ${_buyers.length}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nЗаказов: ${_orders.length}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nИнкассаций: $incassations', style: TextStyle(fontSize: 12.0))
        ]
      )
    );
  }

  Widget _buildPaymentsSubtitle() {
    double cardRepaymentsSum = _cardRepayments.fold(0, (sum, cardRepayment) => sum + cardRepayment.summ);
    double repaymentsSum = _repayments.fold(0, (sum, repayment) => sum + repayment.summ);
    double sum = cardRepaymentsSum + repaymentsSum;
    double kkmSum = _repayments.where((repayment) => repayment.kkmprinted).
      fold(0, (sum, repayment) => sum + repayment.summ);

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(text: 'Всего: ${Format.numberStr(sum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nНаличными: ${Format.numberStr(repaymentsSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nКартой: ${Format.numberStr(cardRepaymentsSum)}', style: TextStyle(fontSize: 12.0)),
          TextSpan(text: '\nККМ: ${Format.numberStr(kkmSum)}', style: TextStyle(fontSize: 12.0))
        ]
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _syncData,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildInfoCards(context)
          );
        }
      )
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
        title: Text('Экспедитор'),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.person),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => PersonPage(), fullscreenDialog: true)
              );
            }
          )
        ]
      ),
      body: _buildBody(context)
    );
  }
}
