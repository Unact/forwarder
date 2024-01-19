part of 'history_page.dart';

class HistoryViewModel extends PageViewModel<HistoryState, HistoryStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;

  StreamSubscription<List<Recept>>? receptsSubscription;
  StreamSubscription<List<Income>>? incomesSubscription;

  HistoryViewModel(this.appRepository, this.ordersRepository) : super(HistoryState());

  @override
  HistoryStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    incomesSubscription = ordersRepository.watchIncomes().listen((event) {
      emit(state.copyWith(status: HistoryStateStatus.dataLoaded, incomes: event));
    });
    receptsSubscription = ordersRepository.watchRecepts().listen((event) {
      emit(state.copyWith(status: HistoryStateStatus.dataLoaded, recepts: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await incomesSubscription?.cancel();
    await receptsSubscription?.cancel();
  }
}
