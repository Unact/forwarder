part of 'entities.dart';

class ApiOrderLineCode extends Equatable {
  final int orderId;
  final int subid;
  final String code;
  final String? groupCode;
  final int amount;
  final bool isDataMatrix;
  final DateTime localTs;

  const ApiOrderLineCode({
    required this.orderId,
    required this.subid,
    required this.code,
    required this.groupCode,
    required this.amount,
    required this.isDataMatrix,
    required this.localTs,
  });

  factory ApiOrderLineCode.fromJson(dynamic json) {
    return ApiOrderLineCode(
      orderId: json['order_id'],
      subid: json['subid'],
      code: json['code'],
      groupCode: json['group_code'],
      isDataMatrix: json['is_data_matrix'],
      amount: json['amount'],
      localTs: Parsing.parseDate(json['local_ts'])!
    );
  }

  OrderLineCode toDatabaseEnt() {
    return OrderLineCode(
      orderId: orderId,
      subid: subid,
      code: code,
      groupCode: groupCode,
      isDataMatrix: isDataMatrix,
      amount: amount,
      localTs: localTs,
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    subid,
    code,
    groupCode,
    amount,
    isDataMatrix,
    localTs
  ];
}
