import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/pages/accept_payment_page.dart';
import 'package:forwarder/app/pages/debt_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';
import 'package:forwarder/app/view_models/accept_payment_view_model.dart';
import 'package:forwarder/app/view_models/buyer_view_model.dart';
import 'package:forwarder/app/view_models/debt_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class BuyerPage extends StatefulWidget {
  BuyerPage({Key key}) : super(key: key);

  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BuyerViewModel _buyerViewModel;
  Completer<void> _dialogCompleter = Completer();
  Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    _buyerViewModel = context.read<BuyerViewModel>();
    _buyerViewModel.addListener(this.vmListener);

    _controllers = Map.fromIterable(
      _buyerViewModel.debts,
      key: (e) => e.id, value: (e) => TextEditingController(text: e.paymentSum?.toString())
    );
  }

  @override
  void dispose() {
    _buyerViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  String _validatePaymentSum(String value) {
    double parsedValue = Nullify.parseDouble(value);

    return value != '' && (parsedValue == null || parsedValue < 0 || parsedValue == 0) ? 'Некорректное значение' : null;
  }

  Future<void> openDialog() async {
    showDialog(
      context: context,
      builder: (_) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  Future<Map<String, dynamic>> showAcceptPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<AcceptPaymentViewModel>(
        create: (context) => AcceptPaymentViewModel(
          context: context,
          debts: _buyerViewModel.debtsToPay,
          isCard: _buyerViewModel.isCard
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
    switch (_buyerViewModel.state) {
      case BuyerState.InProgress:
        openDialog();
        break;
      case BuyerState.OpenDebtSuccess:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider<DebtViewModel>(
              create: (context) => DebtViewModel(context: context, debt: _buyerViewModel.debtToOpen),
              child: DebtPage(),
            )
          )
        );
        break;
      case BuyerState.NeedUserConfirmation:
        _buyerViewModel.confirmationCallback(await showConfirmationDialog(_buyerViewModel.message));
        break;
      case BuyerState.PaymentStarted:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _buyerViewModel.finishPayment(await showAcceptPaymentDialog());
        });
        break;
      case BuyerState.PaymentFinished:
      case BuyerState.OpenDebtFailure:
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_buyerViewModel.message)));
        break;
      case BuyerState.DeliverySuccess:
      case BuyerState.DeliveryFailure:
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_buyerViewModel.message)));
        closeDialog();

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
    return Consumer<BuyerViewModel>(builder: (context, vm, _) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Точка'),
        ),
        persistentFooterButtons: _buildPayButtons(context),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 24, bottom: 24),
          children: [
            _buildBuyerTile(context),
            _buildOrdersTile(context),
            _buildDebtsTile(context)
          ]
        )
      );
    });
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);

    return [
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: !vm.isPayable ? null : () => vm.tryStartPayment(false),
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
      ),
      RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: !vm.isPayable ? null : () => vm.tryStartPayment(true),
        child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
      )
    ];
  }

  Widget _buildBuyerTile(BuildContext context) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);

    return Column(
      children: [
        InfoRow(title: Text('Клиент', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InfoRow(title: Text('Наименование'), trailing: Text(vm.buyer.name)),
              InfoRow(title: Text('Адрес'), trailing: ExpandingText(vm.buyer.address)),
              InfoRow(title: Text('Инкассация'), trailing: ExpandingText(vm.isInc ? 'Да' : 'Нет')),
              InfoRow(title: Text('Долг'), trailing: Text(Format.numberStr(vm.debtsSum))),
              InfoRow(title: Text('Чек'), trailing: Text(Format.numberStr(vm.kkmSum))),
              InfoRow(title: Text('Наличными'), trailing: Text(Format.numberStr(vm.cashPaymentsSum))),
              InfoRow(title: Text('Картой'), trailing: Text(Format.numberStr(vm.cardPaymentsSum))),
            ],
          )
        )
      ],
    );
  }

  Widget _buildOrdersTile(BuildContext context) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);

    return Column(
      children: [
        InfoRow(title: Text('Заказы', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: vm.orders.map((e) => _buildOrderTile(context, e)).toList())
        )
      ],
    );
  }

  Widget _buildDebtsTile(BuildContext context) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);

    return Column(
      children: [
        InfoRow(title: Text('Задолженности', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: vm.debts.map((e) => _buildDebtTile(context, e)).toList())
        )
      ],
    );
  }

  Widget _buildOrderTile(BuildContext context, Order order) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);

    return ListTile(
      dense: true,
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: order.ndoc + '\n', style: TextStyle(color: Colors.black, fontSize: 14.0),),
            TextSpan(
              text: order.info + '\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            TextSpan(
              text: 'Коробов: ${order.mc ?? ''}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            TextSpan(
              text: 'Товаров: ${order.goodsCnt}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ]
        )
      ),
      trailing: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        child: Text('Доставлен', style: TextStyle(color: Colors.white)),
        onPressed: order.isDelivered ? null : () => vm.tryDeliverOrder(order)
      ),
    );
  }


  Widget _buildDebtTile(BuildContext context, Debt debt) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);
    TextEditingController controller = _controllers[debt.id];

    return ListTile(
      onTap: () => vm.onOpenDebt(debt),
      dense: true,
      title: Text(debt.fullname, style: TextStyle(fontSize: 14.0)),
      trailing: GestureDetector(
        child: SizedBox(
          width: 104,
          height: 48,
          child: !vm.debtIsEditable(debt) ?
            Text(Format.numberStr(debt.paymentSum), textAlign: TextAlign.end) :
            TextFormField(
              textAlign: TextAlign.end,
              controller: controller,
              enabled: vm.debtIsEditable(debt),
              maxLines: 1,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              decoration: InputDecoration(
                errorMaxLines: 2,
                isDense: true,
                errorText: _validatePaymentSum(controller.text),
                border: vm.debtIsEditable(debt) ? UnderlineInputBorder() : InputBorder.none
              ),
              onChanged: (newValue) => vm.updateDebtPaymentSum(debt,  Nullify.parseDouble(newValue))
            )
        ),
        onHorizontalDragEnd: (_) {
          controller.text = debt.debtSum.toString();
          vm.updateDebtPaymentSum(debt, debt.debtSum);
          unfocus();
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
            (vm.debtIsEditable(debt)) ? TextSpan() : TextSpan(
              text: 'Оплачено: ${Format.numberStr(debt.paidSum)}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(text: debt.needCheck ? 'Чек' : '', style: TextStyle(color: Colors.red, fontSize: 12.0))
          ]
        )
      ),
    );
  }
}


/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/pages/accept_payment_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/view_models/accept_payment_view_model.dart';
import 'package:forwarder/app/view_models/order_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      builder: (_) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  void showMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<String> showAcceptPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<AcceptPaymentViewModel>(
        create: (context) => AcceptPaymentViewModel(
          context: context,
          order: _orderViewModel.order,
          total: _orderViewModel.total,
          cardPayment: _orderViewModel.cardPayment
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
    switch (_orderViewModel.state) {
      case OrderState.InProgress:
        openDialog();
        break;
      case OrderState.PaymentStarted:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _orderViewModel.finishPayment(await showAcceptPaymentDialog());
        });
        break;
      case OrderState.Failure:
      case OrderState.Canceled:
      case OrderState.PaymentFinished:
      case OrderState.Confirmed:
        showMessage(_orderViewModel.message);
        closeDialog();
        break;
      case OrderState.NeedUserConfirmation:
        _orderViewModel.confirmationCallback(await showConfirmationDialog(_orderViewModel.message));
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
    return Consumer<OrderViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Заказ ${vm.order.trackingNumber}'),
            centerTitle: true
          ),
          persistentFooterButtons: vm.order.isFinished ? null : <Widget>[
            !vm.totalEditable ? null : FlatButton(
              onPressed: () {
                unfocus();
                vm.tryStartPayment(false);
              },
              child: Icon(Icons.account_balance_wallet),
              textColor: Colors.redAccent,
            ),
            !vm.totalEditable ? null : FlatButton(
              onPressed: () {
                unfocus();
                vm.tryStartPayment(true);
              },
              child: Icon(Icons.credit_card),
              textColor: Colors.redAccent,
            ),
            FlatButton(
              textColor: Colors.red,
              child: Text('Отменить'),
              onPressed: () {
                unfocus();
                vm.tryCancelOrder();
              }
            ),
            FlatButton(
              textColor: Colors.red,
              child: Text('Завершить'),
              onPressed: () {
                unfocus();
                vm.tryConfirmOrder();
              }
            ),
          ],
          body: Form(
            key: _formKey,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 24, bottom: 24),
              children: [
                InfoRow(
                  title: Text('Статус'),
                  trailing: Text(
                    vm.order.isCanceled ? 'Отменен' : (vm.order.isFinished ? 'Доставлен' : 'Ожидает доставки')
                  )
                ),
                InfoRow(title: Text('ИМ'), trailing: Text(vm.order.sellerName)),
                InfoRow(title: Text('Номер в ИМ'), trailing: Text(vm.order.number)),
                InfoRow(title: Text('Покупатель'), trailing: Text(vm.order.buyerName)),
                InfoRow(
                  title: Text('Телефон'),
                  trailing: GestureDetector(
                    onTap: vm.callPhone,
                    child: Text(vm.order.phone ?? '', style: TextStyle(color: Colors.blue))
                  )
                ),
                vm.order.deliveryFrom == null ? Container() : InfoRow(
                  title: Text('Время доставки'),
                  trailing: Text(Format.timeStr(vm.order.deliveryFrom) + ' - ' + Format.timeStr(vm.order.deliveryTo))
                ),
                InfoRow(
                  title: Text('Доставка'),
                  trailing: ExpandingText(
                    vm.order.deliveryTypeName +
                      (vm.order.hasElevator ? '\nлифт' : '\nпешком') +
                      (vm.order.floor == null ? '' : '\nэтаж ' + vm.order.floor.toString())+
                      (vm.order.flat == null ? '' : ' квартира ' + vm.order.flat.toString())
                  )
                ),
                InfoRow(title: Text('Оплата'), trailing: Text(vm.order.paymentTypeName)),
                InfoRow(
                  title: Text('Примечание'),
                  trailing: ExpandingText(vm.order.comment ?? '')
                ),
                InfoRow(title: Text('К оплате'), trailing: Text(Format.numberStr(vm.total))),
                ExpansionTile(
                  title: Text('Позиции'),
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.symmetric(horizontal: 8),
                  children: vm.sortedOrderLines.map<Widget>((e) => _buildOrderLineTile(context, e)).toList()
                ),
              ],
            )
          )
        );
      }
    );
  }

  Widget _buildOrderLineTile(BuildContext context, OrderLine orderLine) {
    OrderViewModel vm = Provider.of<OrderViewModel>(context);

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              height: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandingText(orderLine.name, textAlign: TextAlign.left, style: TextStyle(fontSize: 12)),
              )
            )
          ),
          Row(
            children: <Widget>[
              Text(Format.numberStr(orderLine.price) + ' x '),
              vm.order.isFinished ? Text(orderLine.factAmount.toString()) : SizedBox(
                width: 40,
                height: 36,
                child: TextFormField(
                  initialValue: orderLine.factAmount?.toString(),
                  textAlign: TextAlign.center,
                  onChanged: (newValue) => vm.updateOrderLineAmount(orderLine, newValue),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 12)
                  ),
                )
              )
            ],
          )
        ]
      ),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
 */
