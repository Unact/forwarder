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
    emit(state.copyWith(
      status: HistoryStateStatus.dataLoaded,
      incomes: await ordersRepository.getIncomes(),
      recepts: await ordersRepository.getRecepts()
    ));
  }
}
