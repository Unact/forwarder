part of 'entities.dart';

class ApiOrderLinePackError extends Equatable {
  final int id;
  final int orderId;
  final int subid;
  final double volume;
  final int measureId;
  final DateTime localTs;

  const ApiOrderLinePackError({
    required this.id,
    required this.orderId,
    required this.subid,
    required this.volume,
    required this.measureId,
    required this.localTs,
  });

  factory ApiOrderLinePackError.fromJson(dynamic json) {
    return ApiOrderLinePackError(
      id: json['id'],
      orderId: json['order_id'],
      subid: json['subid'],
      volume: Parsing.parseDouble(json['volume'])!,
      measureId: json['measure_id'],
      localTs: Parsing.parseDate(json['local_ts'])!
    );
  }

  OrderLinePackError toDatabaseEnt() {
    return OrderLinePackError(
      id: id,
      orderId: orderId,
      subid: subid,
      volume: volume,
      measureId: measureId,
      localTs: localTs,
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderId,
    subid,
    volume,
    measureId,
    localTs
  ];
}
