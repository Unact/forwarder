import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';

part 'history_state.dart';
part 'history_view_model.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryViewModel>(
      create: (context) => HistoryViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context)
      ),
      child: _HistoryView(),
    );
  }
}

class _HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<_HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.historyPageName),
      ),
      body: BlocBuilder<HistoryViewModel, HistoryState>(builder: (context, state) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
          children: state.operationDates.map((e) => ExpansionTile(
            initiallyExpanded: true,
            title: Text(Format.dateStr(e)),
            tilePadding: const EdgeInsets.all(0),
            childrenPadding: const EdgeInsets.all(0),
            children: _operationDateTiles(context, e)
          )).toList()
        );
      })
    );
  }

  List<Widget> _operationDateTiles(BuildContext context, DateTime date) {
    HistoryViewModel vm = context.read<HistoryViewModel>();
    List<Income> incomes = vm.state.incomes.where((income) => income.ddate == date).toList();
    List<Recept> recepts = vm.state.recepts.where((recept) => recept.ddate == date).toList();

    return [_incomesTile(context, incomes), _receptsTile(context, recepts)];
  }

  Widget _incomesTile(BuildContext context, List<Income> incomes) {
    if (incomes.isEmpty) return Container();

    return InfoRow(
      title: const Text('Приход'),
      trailing: Text(Format.numberStr(incomes.fold<double>(0, (prev, el) => prev + el.summ))),
    );
  }

  Widget _receptsTile(BuildContext context, List<Recept> recepts) {
    if (recepts.isEmpty) return Container();

    return InfoRow(
      title: const Text('Расход'),
      trailing: Text(Format.numberStr(recepts.fold<double>(0, (prev, el) => prev + el.summ))),
    );
  }
}
