part of 'entities.dart';

class ApiFinishTaskData extends Equatable {
  final ApiTask task;
  final List<ApiTaskReturnedLine> taskReturnedLines;

  const ApiFinishTaskData({
    required this.task,
    required this.taskReturnedLines
  });

  factory ApiFinishTaskData.fromJson(dynamic json) {
    return ApiFinishTaskData(
      task: ApiTask.fromJson(json['task']),
      taskReturnedLines: json['task_returned_lines']
        .map<ApiTaskReturnedLine>((e) => ApiTaskReturnedLine.fromJson(e)).toList()
    );
  }

  @override
  List<Object> get props => [
    task,
    taskReturnedLines
  ];
}
