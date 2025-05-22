part of 'entities.dart';

class ApiOrderLineCode extends Equatable {
  final int orderId;
  final int subid;
  final String code;
  final int amount;
  final bool isDataMatrix;
  final DateTime localTs;

  const ApiOrderLineCode({
    required this.orderId,
    required this.subid,
    required this.code,
    required this.amount,
    required this.isDataMatrix,
    required this.localTs,
  });

  factory ApiOrderLineCode.fromJson(dynamic json) {
    return ApiOrderLineCode(
      orderId: json['order_id'],
      subid: json['subid'],
      code: json['code'],
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
    amount,
    isDataMatrix,
    localTs
  ];
}
