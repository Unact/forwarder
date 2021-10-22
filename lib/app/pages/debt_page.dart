import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/pages/accept_payment_page.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';
import 'package:forwarder/app/view_models/accept_payment_view_model.dart';
import 'package:forwarder/app/view_models/debt_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class DebtPage extends StatefulWidget {
  DebtPage({Key? key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  final TextStyle firstColumnTextStyle = TextStyle(color: Colors.blue);
  final EdgeInsets firstColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0, right: 8.0);
  final EdgeInsets baseColumnPadding = EdgeInsets.only(top: 8.0, bottom: 4.0);
  final TextStyle defaultTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
  late final DebtViewModel _debtViewModel;
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
          debts: [_debtViewModel.debt],
          isCard: _debtViewModel.isCard
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
    switch (_debtViewModel.state) {
      case DebtState.NeedUserConfirmation:
        _debtViewModel.confirmationCallback!(await showConfirmationDialog(_debtViewModel.message!));
        break;
      case DebtState.PaymentStarted:
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          _debtViewModel.finishPayment(await showAcceptPaymentDialog());
        });
        break;
      case DebtState.PaymentFinished:
      case DebtState.PaymentFailure:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_debtViewModel.message!)));
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

    if (vm.debt.paymentSum == null) {
      _controller.text = '';
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              InfoRow(trailingFlex: 2, title: Text('Накладная'), trailing: Text(vm.debt.fullname)),
              InfoRow(title: Text('Сумма'), trailing: Text(Format.numberStr(vm.debt.orderSum))),
              InfoRow(title: Text('Долг'), trailing: Text(Format.numberStr(vm.debt.debtSum))),
              InfoRow(title: Text('Оплачено'), trailing: Text(Format.numberStr(vm.debt.paidSum))),
              InfoRow(title: Text('Чек'), trailing: Text(vm.debt.needCheck ? 'Да' : 'Нет')),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                title: Text('Оплата', style: TextStyle(fontSize: 14.0)),
                trailing: !vm.isEditable ?
                  Container() :
                  GestureDetector(
                    child: SizedBox(
                      width: 104,
                      height: 48,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        autofocus: true,
                        controller: _controller,
                        enabled: vm.isEditable,
                        maxLines: 1,
                        style: defaultTextStyle,
                        decoration: InputDecoration(
                          labelText: '',
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.only(),
                          errorMaxLines: 2,
                          isDense: true,
                          errorText: _validatePaymentSum(_controller.text),
                        ),
                        onChanged: (newValue) => vm.updatePaymentSum(Nullify.parseDouble(newValue))
                      )
                    ),
                    onHorizontalDragEnd: (_) {
                      _controller.text = vm.debt.debtSum.toString();
                      vm.updatePaymentSum(vm.debt.debtSum);
                      unfocus();
                    },
                  ),
              )
            ],
          )
        )
      ],
    );
  }

  List<Widget> _buildPayButtons(BuildContext context) {
    DebtViewModel vm = Provider.of<DebtViewModel>(context);

    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.blue
        ),
        child: Text('Оплатить наличными', style: TextStyle(color: Colors.white)),
        onPressed: vm.isEditable ? () => vm.tryStartPayment(false) : null,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.blue
        ),
        child: Text('Оплатить картой', style: TextStyle(color: Colors.white)),
        onPressed: vm.isEditable ? () => vm.tryStartPayment(true) : null,
      )
    ];
  }
}
