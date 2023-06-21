import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/payments/cancel_payment/cancel_payment_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';
import '/app/utils/format.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'payments_state.dart';
part 'payments_view_model.dart';

class PaymentsPage extends StatelessWidget {
  PaymentsPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentsViewModel>(
      create: (context) => PaymentsViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
      ),
      child: _PaymentsView(),
    );
  }
}

class _PaymentsView extends StatefulWidget {
  @override
  _PaymentsViewState createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<_PaymentsView> {
  Future<void> showCancelPaymentDialog() async {
    PaymentsViewModel vm = context.read<PaymentsViewModel>();
    String result = await showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CancelPaymentPage(cardPayment: vm.state.cardPaymentToCancel!)
      ),
      barrierDismissible: false
    ) ?? 'Возврат отменен';

    vm.finishCancelPayment(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.paymentsPageName),
      ),
      body: BlocConsumer<PaymentsViewModel, PaymentsState>(
        builder: (context, state) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                title: const Text('Наличными'),
                tilePadding: const EdgeInsets.all(0),
                childrenPadding: const EdgeInsets.all(0),
                children: state.cashPayments.map((payment) => _cashPaymentTile(context, payment)).toList(),
              ),
              ExpansionTile(
                initiallyExpanded: true,
                title: const Text('Картой'),
                tilePadding: const EdgeInsets.all(0),
                childrenPadding: const EdgeInsets.all(0),
                children: state.cardPayments.map((payment) => _cardPaymentTile(context, payment)).toList(),
              )
            ]
          );
        },
        listener: (context, state) async {
          switch (state.status) {
            case PaymentsStateStatus.cancelStarted:
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await showCancelPaymentDialog();
              });
              break;
            case PaymentsStateStatus.cancelFinished:
              Misc.showMessage(context, state.message);
              break;
            default:
              break;
          }
        }
      )
    );
  }

  Widget _cashPaymentTile(BuildContext context, CashPayment cashPayment) {
    PaymentsViewModel vm = context.read<PaymentsViewModel>();
    Buyer buyer = vm.buyerForCashPayment(cashPayment);
    Color summColor = cashPayment.kkmprinted ? Colors.black : Colors.red;

    return InfoRow(
      titleFlex: 4,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(buyer.name),
          ExpandingText(
            buyer.address,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.left,
            limit: 60
          )
        ]
      ),
      trailing: Text(Format.numberStr(cashPayment.summ), style: TextStyle(color: summColor)),
    );
  }

  Widget _cardPaymentTile(BuildContext context, CardPayment cardPayment) {
    PaymentsViewModel vm = context.read<PaymentsViewModel>();
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
            style: const TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.left,
          )
        ]
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Colors.blue
            ),
            onPressed: cardPayment.canceled || cardPayment.isLink ? null : () => vm.startCancelPayment(cardPayment),
            child: const Text('Отменить', style: TextStyle(color: Colors.white))
          ),
          Container(width: 6),
          SizedBox(
            width: 60,
            child: Text(
              Format.numberStr(cardPayment.summ),
              style: TextStyle(color: summColor),
              textAlign: TextAlign.end,
            )
          )
        ]
      ),
    );
  }
}
