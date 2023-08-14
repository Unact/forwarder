part of 'entities.dart';

class ApiOrderLine extends Equatable {
  final int subid;
  final int orderId;
  final String name;
  final String gtin;
  final double vol;
  final double deliveredVol;
  final double price;
  final bool needMarking;
  final List<String> barcodeRels;

  const ApiOrderLine({
    required this.orderId,
    required this.subid,
    required this.name,
    required this.gtin,
    required this.vol,
    required this.deliveredVol,
    required this.price,
    required this.needMarking,
    required this.barcodeRels
  });

  factory ApiOrderLine.fromJson(dynamic json) {
    return ApiOrderLine(
      orderId: json['order_id'],
      subid: json['subid'],
      name: json['name'],
      gtin: json['gtin'],
      vol: Parsing.parseDouble(json['vol'])!,
      deliveredVol: Parsing.parseDouble(json['delivered_vol'])!,
      price: Parsing.parseDouble(json['price'])!,
      needMarking: json['need_marking'],
      barcodeRels: json['barcode_rels'].split(',')
    );
  }

  OrderLine toDatabaseEnt() {
    return OrderLine(
      subid: subid,
      orderId: orderId,
      name: name,
      gtin: gtin,
      vol: vol,
      deliveredVol: deliveredVol,
      price: price,
      needMarking: needMarking,
      barcodeRels: barcodeRels.map((e) => OrderLineBarcode.fromDart(e)).toList()
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    subid,
    name,
    gtin,
    vol,
    deliveredVol,
    price,
    needMarking,
    barcodeRels
  ];
}
