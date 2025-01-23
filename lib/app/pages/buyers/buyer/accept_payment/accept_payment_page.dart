import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';

part 'accept_payment_state.dart';
part 'accept_payment_view_model.dart';

class AcceptPaymentPage extends StatelessWidget {
  final List<Debt> debts;

  AcceptPaymentPage({
    required this.debts,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcceptPaymentViewModel>(
      create: (context) => AcceptPaymentViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
        debts: debts
      ),
      child: _AcceptPaymentView(),
    );
  }
}

class _AcceptPaymentView extends StatefulWidget {
  @override
  _AcceptPaymentViewState createState() => _AcceptPaymentViewState();
}

class _AcceptPaymentViewState extends State<_AcceptPaymentView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptPaymentViewModel, AcceptPaymentState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildProgressPart(context)
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case AcceptPaymentStateStatus.finished:
          case AcceptPaymentStateStatus.failure:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context, state.message);
            });
            break;
          default:
        }
      }
    );
  }

  List<Widget> _buildProgressPart(BuildContext context) {
    AcceptPaymentViewModel vm = context.read<AcceptPaymentViewModel>();

    return [
      const CircularProgressIndicator(
        backgroundColor: Colors.white70,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      Container(height: 40),
      Text(vm.state.message, style: const TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      Container(height: 40)
    ];
  }
}
