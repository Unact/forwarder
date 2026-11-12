part of 'entities.dart';

class ApiTaskReturnedLine extends Equatable {
  final int id;
  final int taskId;
  final String code;
  final String name;
  final DateTime? deliveryScanned;

  const ApiTaskReturnedLine({
    required this.id,
    required this.taskId,
    required this.code,
    required this.name,
    this.deliveryScanned,
  });

  factory ApiTaskReturnedLine.fromJson(dynamic json) {
    return ApiTaskReturnedLine(
      id: json['id'],
      taskId: json['task_id'],
      code: json['code'],
      name: json['name'],
      deliveryScanned: Parsing.parseDate(json['delivery_scanned'])
    );
  }

  TaskReturnedLine toDatabaseEnt() {
    return TaskReturnedLine(
      id: id,
      taskId: taskId,
      code: code,
      name: name,
      deliveryScanned: deliveryScanned,
    );
  }

  @override
  List<Object?> get props => [
    id,
    taskId,
    code,
    name,
    deliveryScanned
  ];
}
