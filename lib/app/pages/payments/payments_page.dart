import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/buyers_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';

part 'payments_state.dart';
part 'payments_view_model.dart';

class PaymentsPage extends StatelessWidget {
  PaymentsPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentsViewModel>(
      create: (context) => PaymentsViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<BuyersRepository>(context),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.paymentsPageName),
      ),
      body: BlocBuilder<PaymentsViewModel, PaymentsState>(
        builder: (context, state) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: state.cashPayments.map((payment) => _cashPaymentTile(context, payment)).toList(),
          );
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
}
