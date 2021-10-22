import 'package:flutter/material.dart';
import 'package:forwarder/app/view_models/history_view_model.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/widgets/widgets.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.historyPageName),
      ),
      body: Consumer<HistoryViewModel>(builder: (context, vm, _) {
        return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
          children: vm.operationDates.map((e) => ExpansionTile(
            initiallyExpanded: true,
            title: Text(Format.dateStr(e)),
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(0),
            children: _operationDateTiles(context, e)
          )).toList()
        );
      })
    );
  }

  List<Widget> _operationDateTiles(BuildContext context, DateTime date) {
    HistoryViewModel vm = Provider.of<HistoryViewModel>(context);
    List<Income> incomes = vm.incomes.where((income) => income.ddate == date).toList();
    List<Recept> recepts = vm.recepts.where((recept) => recept.ddate == date).toList();

    return [_incomesTile(context, incomes), _receptsTile(context, recepts)];
  }

  Widget _incomesTile(BuildContext context, List<Income> incomes) {
    if (incomes.isEmpty) {
      return Container();
    }

    return InfoRow(
      title: Text('Приход'),
      trailing: Text(Format.numberStr(incomes.fold<double>(0, (prev, el) => prev + el.summ))),
    );
  }

  Widget _receptsTile(BuildContext context, List<Recept> recepts) {
    if (recepts.isEmpty) {
      return Container();
    }

    return InfoRow(
      title: Text('Расход'),
      trailing: Text(Format.numberStr(recepts.fold<double>(0, (prev, el) => prev + el.summ))),
    );
  }
}
