import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forwarder/app/pages/cancel_payment_page.dart';
import 'package:forwarder/app/view_models/cancel_payment_view_model.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/view_models/payments_view_model.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class PaymentsPage extends StatefulWidget {
  PaymentsPage({Key key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PaymentsViewModel _paymentsViewModel;

  @override
  void initState() {
    super.initState();

    _paymentsViewModel = context.read<PaymentsViewModel>();
    _paymentsViewModel.addListener(this.vmListener);
  }

  @override
  void dispose() {
    _paymentsViewModel.removeListener(this.vmListener);
    super.dispose();
  }

  Future<Map<String, dynamic>> showCancelPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<CancelPaymentViewModel>(
        create: (context) => CancelPaymentViewModel(
          context: context,
          cardPayment: _paymentsViewModel.cardPaymentToCancel
        ),
        child: CancelPaymentPage(),
      ),
      barrierDismissible: false
    );
  }

  Future<void> vmListener() async {
    switch (_paymentsViewModel.state) {
      case PaymentsState.CancelStarted:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _paymentsViewModel.finishCancelPayment(await showCancelPaymentDialog());
        });
        break;
      case PaymentsState.CancelFinished:
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_paymentsViewModel.message)));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.paymentsPageName),
      ),
      body: Consumer<PaymentsViewModel>(builder: (context, vm, _) {
        return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Наличными'),
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(0),
              children: vm.cashPayments.map((payment) => _cashPaymentTile(context, payment)).toList(),
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Картой'),
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(0),
              children: vm.cardPayments.map((payment) => _cardPaymentTile(context, payment)).toList(),
            )
          ]
        );
      })
    );
  }

  Widget _cashPaymentTile(BuildContext context, CashPayment cashPayment) {
    PaymentsViewModel vm = Provider.of<PaymentsViewModel>(context);
    Buyer buyer = vm.buyerForCashPayment(cashPayment);
    Color summColor = cashPayment.isKkmprinted ? Colors.black : Colors.red;

    return InfoRow(
      titleFlex: 4,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(buyer.name),
          ExpandingText(
            buyer.address,
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.left,
            limit: 60
          )
        ]
      ),
      trailing: Text(Format.numberStr(cashPayment.summ), style: TextStyle(color: summColor)),
    );
  }

  Widget _cardPaymentTile(BuildContext context, CardPayment cardPayment) {
    PaymentsViewModel vm = Provider.of<PaymentsViewModel>(context);
    Buyer buyer = vm.buyerForCardPayment(cardPayment);
    Color summColor = Colors.black;

    return InfoRow(
      titleFlex: 1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(buyer.name),
          ExpandingText(
            buyer.address,
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.left,
          )
        ]
      ),
      trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: Colors.blue,
              child: Text('Отменить', style: TextStyle(color: Colors.white)),
              onPressed: cardPayment.isCanceled ? null : () => vm.startCancelPayment(cardPayment)
            ),
            Container(width: 6),
            Container(
              width: 60,
              child: Text(
                Format.numberStr(cardPayment.summ),
                style: TextStyle(color: summColor),
                textAlign: TextAlign.end,
              ),
            )
          ]
        ),
    );
  }
}
