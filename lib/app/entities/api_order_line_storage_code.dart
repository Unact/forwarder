part of 'entities.dart';

class ApiOrderLineStorageCode extends Equatable {
  final int orderId;
  final int subid;
  final String code;
  final String? groupCode;
  final int amount;

  const ApiOrderLineStorageCode({
    required this.orderId,
    required this.subid,
    required this.code,
    required this.groupCode,
    required this.amount
  });

  factory ApiOrderLineStorageCode.fromJson(dynamic json) {
    return ApiOrderLineStorageCode(
      orderId: json['order_id'],
      subid: json['subid'],
      code: json['code'],
      groupCode: json['group_code'],
      amount: json['amount']
    );
  }

  OrderLineStorageCode toDatabaseEnt() {
    return OrderLineStorageCode(
      orderId: orderId,
      subid: subid,
      code: code,
      groupCode: groupCode,
      amount: amount,
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    subid,
    code,
    groupCode,
    amount
  ];
}
