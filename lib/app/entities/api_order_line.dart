part of 'entities.dart';

class ApiOrderLine extends Equatable {
  final int subid;
  final int orderId;
  final String name;
  final String gtin;
  final double vol;
  final double price;
  final bool needMarking;
  final List<String> barcodes;

  const ApiOrderLine({
    required this.orderId,
    required this.subid,
    required this.name,
    required this.gtin,
    required this.vol,
    required this.price,
    required this.needMarking,
    required this.barcodes
  });

  factory ApiOrderLine.fromJson(dynamic json) {
    return ApiOrderLine(
      orderId: json['order_id'],
      subid: json['subid'],
      name: json['name'],
      gtin: json['gtin'],
      vol: Parsing.parseDouble(json['vol'])!,
      price: Parsing.parseDouble(json['price'])!,
      needMarking: json['need_marking'],
      barcodes: json['barcodes'].split(',')
    );
  }

  OrderLine toDatabaseEnt() {
    return OrderLine(
      subid: subid,
      orderId: orderId,
      name: name,
      gtin: gtin,
      vol: vol,
      price: price,
      needMarking: needMarking,
      barcodes: barcodes
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    subid,
    name,
    gtin,
    vol,
    price,
    needMarking,
    barcodes
  ];
}
