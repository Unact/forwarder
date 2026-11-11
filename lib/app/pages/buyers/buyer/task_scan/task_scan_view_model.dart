part of 'task_scan_page.dart';

class TaskScanViewModel extends PageViewModel<TaskScanState, TaskScanStateStatus> {
  final TasksRepository tasksRepository;

  StreamSubscription<List<TaskReturnedLine>>? taskReturnedLinesSubscription;

  TaskScanViewModel(this.tasksRepository, {required Task task}) :
    super(TaskScanState(task: task));

  @override
  TaskScanStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    taskReturnedLinesSubscription = tasksRepository.watchTaskReturnedLinesByTaskId(state.task.id)
      .listen((event) {
        emit(state.copyWith(status: TaskScanStateStatus.dataLoaded, taskReturnedLines: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await taskReturnedLinesSubscription?.cancel();
  }

  Future<void> readCode(String code) async {
    TaskReturnedLine? returnedLine = state.taskReturnedLines.firstWhereOrNull((e) => e.code == code);

    if (returnedLine == null) {
      emit(state.copyWith(status: TaskScanStateStatus.failure, message: 'Код не найден. $code'));
      return;
    }

    await tasksRepository.scanTaskReturnedLineCode(returnedLine);

    emit(state.copyWith(
      status: TaskScanStateStatus.success,
      lastScannedTaskReturnedLine: (value: returnedLine),
      message: 'Код успешно отсканирован'
    ));
  }
}
