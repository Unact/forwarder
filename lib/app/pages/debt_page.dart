import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/pages/accept_payment_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';
import 'package:forwarder/app/view_models/accept_payment_view_model.dart';
import 'package:forwarder/app/view_models/debt_view_model.dart';

class DebtPage extends StatefulWidget {
  DebtPage({Key key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle firstColumnTextStyle = TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
  DebtViewModel _debtViewModel;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _debtViewModel = context.read<DebtViewModel>();
    _debtViewModel.addListener(this.vmListener);
  }

  @override
  void dispose() {
    _debtViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  String _validatePaymentSum(String value) {
    double parsedValue = Nullify.parseDouble(value);

    return value != '' && (parsedValue == null || parsedValue < 0 || parsedValue == 0) ? 'Некорректное значение' : null;
  }

  Future<Map<String, dynamic>> showAcceptPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<AcceptPaymentViewModel>(
        create: (context) => AcceptPaymentViewModel(
          context: context,
          debts: [_debtViewModel.debt],
          isCard: _debtViewModel.isCard
        ),
        child: AcceptPaymentPage(),
      ),
      barrierDismissible: false
    );
  }

  Future<bool> showConfirmationDialog(String message) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            FlatButton(child: Text(Strings.ok), onPressed: () => Navigator.of(context).pop(true)),
            FlatButton(child: Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        );
      }
    );
  }

  Future<void> vmListener() async {
    switch (_debtViewModel.state) {
      case DebtState.NeedUserConfirmation:
        _debtViewModel.confirmationCallback(await showConfirmationDialog(_debtViewModel.message));
        break;
      case DebtState.PaymentStarted:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _debtViewModel.finishPayment(await showAcceptPaymentDialog());
        });
        break;
      case DebtState.PaymentFinished:
      case DebtState.PaymentFailure:
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_debtViewModel.message)));
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
    return Consumer<DebtViewModel>(builder: (context, vm, _) {
      return Scaffold(
        key: _scaffoldKey,
        persistentFooterButtons: _buildPayButtons(context),
        appBar: AppBar(
          title: Text('Задолженность'),
        ),
        body: _buildBody(context)
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    DebtViewModel vm = Provider.of<DebtViewModel>(context);

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
            initialValue: vm.debt.fullname,
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
            initialValue: Format.numberStr(vm.debt.orderSum)
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
            initialValue: Format.numberStr(vm.debt.debtSum)
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
            initialValue: vm.debt.needCheck ? 'Да' : 'Нет'
          )
        ),
        Container(height: 32),
        _buildListViewItem(
          GestureDetector(
            child: TextFormField(
              autofocus: true,
              controller: _controller,
              enabled: vm.isEditable,
              maxLines: 1,
              style: defaultTextStyle,
              decoration: InputDecoration(
                labelText: 'Оплата',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(),
                prefixIcon: Icon(Icons.attach_money),
                errorMaxLines: 2,
                isDense: true,
                errorText: _validatePaymentSum(_controller.text),
              ),
              onChanged: (newValue) => vm.updatePaymentSum(Nullify.parseDouble(newValue))
            ),
            onHorizontalDragEnd: (_) {
              _controller.text = vm.debt.debtSum.toString();
              vm.updatePaymentSum(vm.debt.debtSum);
              unfocus();
            },
          ),
        ),
      ]
    );
  }

  Widget _buildListViewItem(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: child
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    DebtViewModel vm = Provider.of<DebtViewModel>(context);

    return [
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: vm.isEditable ? () => vm.tryStartPayment(false) : null,
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
      ),
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: vm.isEditable ? () => vm.tryStartPayment(true) : null,
        child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
      )
    ];
  }
}
