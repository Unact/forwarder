import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/pages/accept_payment_page.dart';
import 'package:forwarder/app/pages/debt_page.dart';
import 'package:forwarder/app/pages/order_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';
import 'package:forwarder/app/view_models/accept_payment_view_model.dart';
import 'package:forwarder/app/view_models/buyer_view_model.dart';
import 'package:forwarder/app/view_models/debt_view_model.dart';
import 'package:forwarder/app/view_models/order_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class BuyerPage extends StatefulWidget {
  BuyerPage({Key? key}) : super(key: key);

  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  late final BuyerViewModel _buyerViewModel;
  Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    _buyerViewModel = context.read<BuyerViewModel>();
    _buyerViewModel.addListener(this.vmListener);
  }

  @override
  void dispose() {
    _buyerViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  String? _validatePaymentSum(String value) {
    double? parsedValue = Nullify.parseDouble(value);

    return value != '' && (parsedValue == null || parsedValue < 0 || parsedValue == 0) ? 'Некорректное значение' : null;
  }

  Future<AcceptPaymentResult> showAcceptPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<AcceptPaymentViewModel>(
        create: (context) => AcceptPaymentViewModel(
          context: context,
          debts: _buyerViewModel.debtsToPay,
          isCard: _buyerViewModel.isCard
        ),
        child: WillPopScope(
          onWillPop: () async => false,
          child: AcceptPaymentPage(),
        )
      ),
      barrierDismissible: false
    );
  }

  Future<bool> showConfirmationDialog(String message) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            TextButton(child: Text(Strings.ok), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        )
      )
    ) ?? false;
  }

  Future<void> vmListener() async {
    switch (_buyerViewModel.state) {
      case BuyerState.NeedUserConfirmation:
        _buyerViewModel.confirmationCallback!(await showConfirmationDialog(_buyerViewModel.message!));
        break;
      case BuyerState.PaymentStarted:
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          _buyerViewModel.finishPayment(await showAcceptPaymentDialog());
        });
        break;
      case BuyerState.PaymentFinished:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_buyerViewModel.message!)));
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
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.blue
        ),
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
        onPressed: !vm.isPayable ? null : () => vm.tryStartPayment(false),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.blue
        ),
        child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
        onPressed: !vm.isPayable ? null : () => vm.tryStartPayment(true),
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
              InfoRow(title: Text('Наименование'), trailing: Text(vm.buyer.name), trailingFlex: 2),
              InfoRow(title: Text('Адрес'), trailing: ExpandingText(vm.buyer.address), trailingFlex: 2),
              InfoRow(title: Text('Инкассация'), trailing: Text(vm.isInc ? 'Да' : 'Нет')),
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
    String delivered = order.isDelivered ? Strings.yes : (order.isUndelivered ? Strings.no : Strings.inProcess);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 8),
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: order.ndoc + '\n', style: TextStyle(color: Colors.black, fontSize: 14.0),),
            TextSpan(
              text: order.info + '\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            TextSpan(
              text: 'Доставлен: $delivered\n',
              style: TextStyle(color: Colors.blue, fontSize: 12.0),
            ),
          ]
        )
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider<OrderViewModel>(
              create: (context) => OrderViewModel(context: context, order: order),
              child: OrderPage(),
            )
          )
        );
      }
    );
  }


  Widget _buildDebtTile(BuildContext context, Debt debt) {
    BuyerViewModel vm = Provider.of<BuyerViewModel>(context);
    TextEditingController? controller = _controllers[debt.id];

    if (controller == null) {
      controller = TextEditingController(text: debt.paymentSum?.toString());

      _controllers[debt.id] = controller;
    }

    if (debt.paymentSum == null) {
      controller.text = '';
    }

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 8),
      title: Text(debt.fullname),
      trailing: !vm.debtIsEditable(debt) ?
        null :
        GestureDetector(
          child: SizedBox(
            width: 104,
            height: 48,
            child:
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
            controller!.text = debt.debtSum.toString();
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
            TextSpan(
              text: 'Оплачено: ${Format.numberStr(debt.paidSum)}\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(text: debt.needCheck ? 'Чек' : '', style: TextStyle(color: Colors.red, fontSize: 12.0))
          ]
        )
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider<DebtViewModel>(
              create: (context) => DebtViewModel(context: context, debt: debt),
              child: DebtPage(),
            )
          )
        );
      },
    );
  }
}
