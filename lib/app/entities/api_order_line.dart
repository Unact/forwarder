part of 'entities.dart';

class ApiOrderLine extends Equatable {
  final int subid;
  final int orderId;
  final String name;
  final String gtin;
  final double vol;
  final bool needMarking;

  const ApiOrderLine({
    required this.orderId,
    required this.subid,
    required this.name,
    required this.gtin,
    required this.vol,
    required this.needMarking
  });

  factory ApiOrderLine.fromJson(dynamic json) {
    return ApiOrderLine(
      orderId: json['order_id'],
      subid: json['subid'],
      name: json['name'],
      gtin: json['gtin'],
      vol: Parsing.parseDouble(json['vol'])!,
      needMarking: json['need_marking']
    );
  }

  OrderLine toDatabaseEnt() {
    return OrderLine(
      subid: subid,
      orderId: orderId,
      name: name,
      gtin: gtin,
      vol: vol,
      needMarking: needMarking
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    subid,
    name,
    gtin,
    vol,
    needMarking
  ];
}