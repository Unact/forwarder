import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/view_models/order_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle firstColumnTextStyle = TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
  OrderViewModel _orderViewModel;
  Completer<void> _dialogCompleter = Completer();

  @override
  void initState() {
    super.initState();

    _orderViewModel = context.read<OrderViewModel>();
    _orderViewModel.addListener(this.vmListener);
  }

  @override
  void dispose() {
    _orderViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  Future<void> openDialog() async {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(child: CircularProgressIndicator())
      ),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  Future<bool> showConfirmationDialog(String message) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Подтверждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            FlatButton(child: Text('Подтверждаю'), onPressed: () => Navigator.of(context).pop(true)),
            FlatButton(child: Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        )
      )
    );
  }

  Future<void> vmListener() async {
    switch (_orderViewModel.state) {
      case OrderState.InProgress:
        openDialog();
        break;
      case OrderState.NeedUserConfirmation:
        _orderViewModel.confirmationCallback(await showConfirmationDialog(_orderViewModel.message));
        break;
      case OrderState.DeliveryFinished:
      case OrderState.DeliveryFailure:
        closeDialog();
        _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(_orderViewModel.message)));
        break;
      default:
    }
  }

  void unfocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(builder: (context, vm, _) {
      return Scaffold(
        key: _scaffoldKey,
        persistentFooterButtons: _buildPayButtons(context),
        appBar: AppBar(
          title: Text('Заказ'),
        ),
        body: _buildBody(context)
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    OrderViewModel vm = Provider.of<OrderViewModel>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              InfoRow(title: Text('Номер'), trailing: Text(vm.order.ndoc)),
              InfoRow(title: Text('Комментарий'), trailing: ExpandingText(vm.order.info)),
              InfoRow(title: Text('Коробов'), trailing: Text(Format.numberStr(vm.order.mc))),
              InfoRow(title: Text('Товаров'), trailing: Text(vm.order.goodsCnt.toString())),
              InfoRow(
                title: Text('Доставлен'),
                trailing: Text(
                  vm.order.isDelivered ? Strings.yes : (vm.order.isUndelivered ? Strings.no : Strings.inProcess)
                )
              )
            ],
          )
        )
      ],
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    OrderViewModel vm = Provider.of<OrderViewModel>(context);

    return [
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: vm.isEditable ? () => vm.tryDeliverOrder(true) : null,
        child: Text('Доставлен', style: TextStyle(color: Colors.white)),
      ),
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: vm.isEditable ? () => vm.tryDeliverOrder(false) : null,
        child: Text('Не доставлен', style: TextStyle(color: Colors.white)),
      )
    ];
  }
}
