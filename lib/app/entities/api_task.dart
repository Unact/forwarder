part of 'entities.dart';

class ApiTask extends Equatable {
  final int id;
  final int buyerId;
  final int deliveryId;
  final String taskTypeName;
  final String taskNumber;
  final String? info;
  final bool? completed;

  const ApiTask({
    required this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.taskTypeName,
    required this.taskNumber,
    this.info,
    required this.completed,
  });

  factory ApiTask.fromJson(dynamic json) {
    return ApiTask(
      id: json['id'],
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      taskTypeName: json['task_type_name'],
      taskNumber: json['task_number'],
      info: json['info'],
      completed: json['completed']
    );
  }

  Task toDatabaseEnt() {
    return Task(
      id: id,
      buyerId: buyerId,
      deliveryId: deliveryId,
      taskTypeName: taskTypeName,
      taskNumber: taskNumber,
      info: info,
      completed: completed
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    deliveryId,
    taskTypeName,
    taskNumber,
    info,
    completed
  ];
}
