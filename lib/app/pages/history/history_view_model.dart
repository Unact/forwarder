part of 'history_page.dart';

class HistoryViewModel extends PageViewModel<HistoryState, HistoryStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;

  HistoryViewModel(this.appRepository, this.ordersRepository) :
    super(HistoryState(), [appRepository, ordersRepository]);

  @override
  HistoryStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<Income> incomes = await ordersRepository.getIncomes();
    List<Recept> recepts = await ordersRepository.getRecepts();

    emit(state.copyWith(
      status: HistoryStateStatus.dataLoaded,
      incomes: incomes,
      recepts: recepts
    ));
  }
}
