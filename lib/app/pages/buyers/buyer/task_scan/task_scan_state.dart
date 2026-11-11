part of 'task_scan_page.dart';

enum TaskScanStateStatus {
  initial,
  dataLoaded,
  failure,
  success
}

class TaskScanState {
  TaskScanState({
    this.status = TaskScanStateStatus.initial,
    this.message = '',
    required this.task,
    this.taskReturnedLines = const [],
    this.lastScannedTaskReturnedLine
  });

  final TaskScanStateStatus status;
  final String message;
  final Task task;
  final List<TaskReturnedLine> taskReturnedLines;
  final TaskReturnedLine? lastScannedTaskReturnedLine;

  List<String> get codes => taskReturnedLines.map((e) => e.code).toList();

  TaskScanState copyWith({
    TaskScanStateStatus? status,
    String? message,
    List<TaskReturnedLine>? taskReturnedLines,
    ({ TaskReturnedLine? value })? lastScannedTaskReturnedLine
  }) {
    return TaskScanState(
      status: status ?? this.status,
      message: message ?? this.message,
      task: task,
      taskReturnedLines: taskReturnedLines ?? this.taskReturnedLines,
      lastScannedTaskReturnedLine: lastScannedTaskReturnedLine != null
        ? lastScannedTaskReturnedLine.value
        : this.lastScannedTaskReturnedLine
    );
  }
}
