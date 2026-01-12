part of 'entities.dart';

class ApiFinishTaskData extends Equatable {
  final ApiTask task;

  const ApiFinishTaskData({
    required this.task
  });

  factory ApiFinishTaskData.fromJson(dynamic json) {
    return ApiFinishTaskData(
      task: ApiTask.fromJson(json['task'])
    );
  }

  @override
  List<Object> get props => [
    task
  ];
}
