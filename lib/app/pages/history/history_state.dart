part of 'history_page.dart';

enum HistoryStateStatus {
  initial,
  dataLoaded
}

class HistoryState {
  HistoryState({
    this.status = HistoryStateStatus.initial,
    this.incomes = const [],
    this.recepts = const []
  });

  final HistoryStateStatus status;

  final List<Income> incomes;
  final List<Recept> recepts;

  List<DateTime> get operationDates {
    Set<DateTime> dates = recepts.map((e) => e.ddate).toSet()..addAll(incomes.map((e) => e.ddate));

    return dates.toList()..sort((date1, date2) => date2.compareTo(date1));
  }

  HistoryState copyWith({
    HistoryStateStatus? status,
    List<Income>? incomes,
    List<Recept>? recepts,
  }) {
    return HistoryState(
      status: status ?? this.status,
      incomes: incomes ?? this.incomes,
      recepts: recepts ?? this.recepts
    );
  }
}
