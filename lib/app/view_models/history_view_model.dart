import 'package:flutter/material.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

class HistoryViewModel extends BaseViewModel {
  HistoryViewModel({required BuildContext context}) : super(context: context);

  List<Income> get incomes => appState.incomes;
  List<Recept> get recepts => appState.recepts;
  List<DateTime> get operationDates {
    Set<DateTime> dates = appState.recepts.map((e) => e.ddate).toSet()..addAll(appState.incomes.map((e) => e.ddate));

    return dates.toList()..sort((date1, date2) => date2.compareTo(date1));
  }
}
