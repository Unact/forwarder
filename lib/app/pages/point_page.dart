import 'package:flutter/material.dart';

import 'package:forwarder/app/models/card_repayment.dart';
import 'package:forwarder/app/models/buyer.dart';
import 'package:forwarder/app/models/debt.dart';
import 'package:forwarder/app/models/order.dart';
import 'package:forwarder/app/models/repayment.dart';
import 'package:forwarder/app/modules/api.dart';
import 'package:forwarder/app/pages/card_payment_page.dart';
import 'package:forwarder/app/pages/cash_payment_page.dart';
import 'package:forwarder/app/pages/debt_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/geo_loc.dart';

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
              text: 'Коробов: ${order.mc ?? ''}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Товаров: ${order.goodsCnt}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
          ]
        )
      ),
      trailing: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        child: Text('Доставлен', style: TextStyle(color: Colors.white)),
        onPressed: order.delivered ? null : () => _showConfirmDialog(order)
      ),
    );
  }

  Future<void> _showConfirmDialog(Order order) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Предупреждение'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Вы подтверждаете что передали заказ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Да'),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDelivery(order);
              },
            ),
            FlatButton(
              child: Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildDebtsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _debts.map((Debt debt) => _buildDebtRow(debt)).toList()
    );
  }

  Widget _buildDebtRow(Debt debt) {
    bool isEditable = debt.paidSum == null;
    TextEditingController paymentController = TextEditingController();

    paymentController.text = debt.paymentSum != null ? Format.numberStr(debt.paymentSum) : '';

    return ListTile(
      onTap: () async {
        if (isEditable) {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => DebtPage(debt: debt)));
          await _loadData();
          setState(() {});
        } else {
          _showSnackBar('Для этой задолженности уже есть оплата на сегодня');
        }
      },
      dense: true,
      title: Text(debt.fullname),
      trailing: GestureDetector(
        child: Container(
          width: 96,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: paymentController,
            enabled: isEditable,
            maxLines: 1,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            decoration: InputDecoration(
              labelText: '',
              border: isEditable ? UnderlineInputBorder() : InputBorder.none,
              contentPadding: EdgeInsets.only(),
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

                debt.paymentSum = parsedValue;
              });
            }
          )
        ),
        onHorizontalDragEnd: (_) {
          setState(() {
            debt.paymentSum = debt.debtSum;
            paymentController.text = Format.numberStr(debt.paymentSum);

            FocusScope.of(context).unfocus();
          });
        },
      ),
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
            (!isEditable) ?
              TextSpan(
                text: 'Оплачено: ${Format.numberStr(debt.paidSum)}\n',
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

  List<Widget> _buildPayButtons() {
    bool isEnabled = _debts.any((debt) => debt.paymentSum != null);

    return [
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: !isEnabled ? null : () async {
          await _pay(card: false);
        },
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
      ),
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: !isEnabled ? null : () async {
          await _pay(card: true);
        },
        child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
      )
    ];
  }

  Future<void> _confirmDelivery(Order order) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(padding: EdgeInsets.all(5.0), child: Center(child: CircularProgressIndicator()));
      }
    );

    try {
      await Api.post('v1/forwarder/confirm_delivery', data: {
        'sale_order_id': order.id,
        'location': await GeoLoc.getCurrentLocation(),
        'local_ts': DateTime.now().toIso8601String()
      });
      setState(() {
        order.delivered = true;
      });
      await order.update();

      _showSnackBar('Информация о доставке сохранена');
    } on ApiException catch(e) {
      _showSnackBar(e.errorMsg);
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> _confirmPayment(double paymentSum) async {
    String warningText = 'Вы уверены, что хотите внести оплату ${Format.numberStr(paymentSum)} руб.?\n' +
      'Изменить потом будет нельзя.';

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(warningText)])),
          actions: <Widget>[
            FlatButton(child: Text('Да'), onPressed: () => Navigator.of(context).pop(true)),
            FlatButton(child: Text('Нет'), onPressed: () => Navigator.of(context).pop(false))
          ],
        );
      }
    );
  }

  Future<void> _pay({bool card}) async {
    List<Debt> debts = _debts.where((debt) => debt.paymentSum != null).toList();
    double paymentSum = debts.map((debt) => debt.paymentSum).reduce((acc, el) => acc + el);
    Map<String, dynamic> location = await GeoLoc.getCurrentLocation();

    if (debts.isEmpty || paymentSum <= 0) {
      _showSnackBar('Указана неверная сумма оплаты');
      return;
    }

    if (card && debts.any((debt) => debt.paymentSum > debt.debtSum)) {
      _showSnackBar('Указана неверная сумма для оплаты картой');
      return;
    }

    if (!await _confirmPayment(paymentSum)) {
      setState(() {
        debts.forEach((debt) => debt.paymentSum = null);
      });

      return;
    }

    Map<String, dynamic> result = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => card ?
        CardPaymentPage(debts: debts, location: location) :
        CashPaymentPage(debts: debts, location: location)
    );

    setState(() {
      if (result['success']) {
        _showSnackBar('Оплаты успешно созданы');
        _loadData();
        return;
      }

      _showSnackBar('Произошла ошибка - ${result['errorMessage']}');
    });
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
      body: _buildBody(context),
      persistentFooterButtons: _buildPayButtons()
    );
  }
}
