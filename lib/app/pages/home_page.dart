import 'package:flutter/material.dart';

import 'package:forwarder/app/pages/info_page.dart';
import 'package:forwarder/app/pages/points_page.dart';
import 'package:forwarder/app/pages/payments_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _bottomNavigationBarKey = GlobalKey();
  int _currentIndex = 0;
  List<Widget> _children = [];

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      key: _bottomNavigationBarKey,
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() => _currentIndex = index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Главная')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store),
          title: Text('Точки'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          title: Text('Оплаты'),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return _children[_currentIndex];
  }

  @override
  void initState() {

    super.initState();
    _children = [
      InfoPage(bottomNavigationBarKey: _bottomNavigationBarKey),
      PointsPage(),
      PaymentsPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: _buildBody(context)
    );
  }
}
