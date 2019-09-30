import 'package:flutter/material.dart';

import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/order.dart';
import 'package:forwarder/app/pages/point_page.dart';

class PointsPage extends StatefulWidget {
  PointsPage({Key key}) : super(key: key);

  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> with WidgetsBindingObserver {
  List<Buyer> _buyers = [];
  List<Order> _orders = [];

  Future<void> _loadData() async {
    _buyers = await Buyer.allSorted();
    _orders = await Order.all();

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: _buyers.map((buyer) => _pointTile(context, buyer)).toList());
  }

  Widget _pointTile(BuildContext context, Buyer buyer) {
    List<Order> buyerOrders = _orders.where((order) => order.buyerId == buyer.id).toList();
    bool inc = buyerOrders.any((order) => order.inc) || buyerOrders.length == 0;

    return ListTile(
      dense: true,
      title: Text(buyer.name, style: TextStyle(fontSize: 14.0)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PointPage(buyer: buyer, inc: inc)));
      },
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: buyer.address + '\n', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
            TextSpan(text: 'Заказов: ${buyerOrders.length}\n', style: TextStyle(color: Colors.blue, fontSize: 12.0)),
            TextSpan(text: inc ? 'Требуется инкассация' : '', style: TextStyle(color: Colors.blue, fontSize: 12.0))
          ]
        )
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
      appBar: AppBar(
        title: Text('Точки')
      ),
      body: _buildBody(context)
    );
  }
}
