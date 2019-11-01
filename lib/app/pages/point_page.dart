import 'package:flutter/material.dart';

import 'package:forwarder/app/models/card_repayment.dart';
import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/models/order.dart';
import 'package:forwarder/app/models/repayment.dart';
import 'package:forwarder/app/pages/debt_page.dart';
import 'package:forwarder/app/utils/format.dart';

class PointPage extends StatefulWidget {
  final Buyer buyer;
  final bool inc;
  PointPage({Key key, @required this.buyer, @required this.inc}) : super(key: key);

  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EdgeInsets headingPadding = EdgeInsets.only(top: 4.0, bottom: 4.0);
  final TextStyle headingStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, height: 24.0/15.0);
  List<Order> _orders = [];
  List<Debt> _debts = [];
  List<Repayment> _repayments = [];
  List<CardRepayment> _cardRepayments = [];

  Future<void> _loadData() async {
    _orders = (await Order.all()).where((order) => order.buyerId == widget.buyer.id).toList();
    _debts = (await Debt.all()).where((debt) => debt.buyerId == widget.buyer.id).toList();
    _repayments = (await Repayment.all()).where((repayment) => repayment.buyerId == widget.buyer.id).toList();
    _cardRepayments = (await CardRepayment.all()).
      where((cardRepayment) => cardRepayment.buyerId == widget.buyer.id).toList();

    if (mounted) {
      setState(() {});
    }
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 64.0),
      children: <Widget>[
        Padding(
          padding: headingPadding,
          child: Text('Клиент', style: headingStyle)
        ),
        _buildListViewItem(_buildTable()),
        Padding(
          padding: headingPadding,
          child: Text('Заказы', style: headingStyle)
        ),
        _buildOrdersColumn(),
        Padding(
          padding: headingPadding,
          child: Text('Задолженности', style: headingStyle)
        ),
        _buildDebtsColumn()
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
    double debtsSum = _debts.fold(0, (sum, debt) => sum + debt.debtSum);
    double repaymentsSum = _repayments.fold(0, (sum, repayment) => sum + repayment.summ);
    double repaymentsCheckSum = _repayments.where((repayment) => repayment.kkmprinted).
      fold(0, (sum, repayment) => sum + repayment.summ);
    double cardRepaymentsSum = _cardRepayments.fold(0, (sum, cardRepayment) => sum + cardRepayment.summ);

    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(112.0),
      },
      children: <TableRow>[
        _buildTableRow('', widget.buyer.name.toString()),
        _buildTableRow('Адрес', widget.buyer.address.toString()),
        _buildTableRow('Инкассация', widget.inc ? 'Да' : 'Нет'),
        _buildTableRow('Долг', Format.numberStr(debtsSum)),
        _buildTableRow('Чек', Format.numberStr(repaymentsCheckSum)),
        _buildTableRow('Наличными', Format.numberStr(repaymentsSum)),
        _buildTableRow('Картой', Format.numberStr(cardRepaymentsSum)),
      ]
    );
  }

  Widget _buildOrdersColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _orders.map((Order order) => _buildOrderRow(order)).toList()
    );
  }

  Widget _buildOrderRow(Order order) {
    return ListTile(
      dense: true,
      title: Text(order.ndoc),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: order.info + '\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Коробов: ${order.mc}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Товаров: ${order.goodsCnt}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
          ]
        )
      ),
    );
  }

  Widget _buildDebtsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _debts.map((Debt debt) => _buildDebtRow(debt)).toList()
    );
  }

  Widget _buildDebtRow(Debt debt) {
    Repayment rep = _repayments.firstWhere((repayment) => repayment.orderId == debt.orderId, orElse: () => null);
    CardRepayment cardRep = _cardRepayments.
      firstWhere((cardRepayment) => cardRepayment.orderId == debt.orderId, orElse: () => null);

    return ListTile(
      onTap: () async {
        if (rep == null && cardRep == null) {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => DebtPage(debt: debt)));
          await _loadData();
          setState(() {});
        } else {
          _showSnackBar('Для этой задолженности уже есть оплата на сегодня');
        }
      },
      dense: true,
      title: Text(debt.fullname),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Сумма: ${Format.numberStr(debt.orderSum)}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Долг: ${Format.numberStr(debt.debtSum)}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            (rep != null || cardRep != null) ?
              TextSpan(
                text: 'Оплачено: ${Format.numberStr(rep?.summ ?? cardRep.summ)}\n',
                style: TextStyle(color: Colors.grey, fontSize: 12.0)
              ) :
              TextSpan(),
            TextSpan(text: debt.isCheck ? 'Чек' : '', style: TextStyle(color: Colors.red, fontSize: 12.0))
          ]
        )
      ),
    );
  }

  TableRow _buildTableRow(String leftStr, String rightStr) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8),
          child: Text(leftStr, style: TextStyle(color: Colors.blue), textAlign: TextAlign.end)
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
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
        title: Text('Точка')
      ),
      body: _buildBody(context)
    );
  }
}
