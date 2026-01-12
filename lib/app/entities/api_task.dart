part of 'entities.dart';

class ApiTask extends Equatable {
  final int id;
  final int buyerId;
  final int deliveryId;
  final String taskTypeName;
  final bool status;

  const ApiTask({
    required this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.taskTypeName,
    required this.status,
  });

  factory ApiTask.fromJson(dynamic json) {
    return ApiTask(
      id: json['id'],
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      taskTypeName: json['task_type_name'],
      status: Parsing.parseBool(json['status'])!
    );
  }

  Task toDatabaseEnt() {
    return Task(
      id: id,
      buyerId: buyerId,
      deliveryId: deliveryId,
      taskTypeName: taskTypeName,
      status: status
    );
  }

  @override
  List<Object> get props => [
    id,
    buyerId,
    deliveryId,
    taskTypeName,
    status
  ];
}
