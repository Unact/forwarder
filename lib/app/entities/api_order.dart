part of 'entities.dart';

class ApiOrder extends Equatable {
  final int id;
  final int buyerId;
  final int deliveryId;
  final int ord;
  final String ndoc;
  final String info;
  final int inc;
  final int goodsCnt;
  final double mc;
  final bool? delivered;
  final bool physical;
  final bool paid;
  final bool needScan;

  const ApiOrder({
    required this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.ord,
    required this.ndoc,
    required this.info,
    required this.inc,
    required this.goodsCnt,
    required this.mc,
    this.delivered,
    required this.physical,
    required this.paid,
    required this.needScan
  });

  factory ApiOrder.fromJson(dynamic json) {
    return ApiOrder(
      id: json['id'],
      buyerId: json['buyer_id'],
      deliveryId: json['delivery_id'],
      ord: json['ord'],
      ndoc: json['ndoc'],
      info: json['info'],
      inc: json['inc'],
      goodsCnt: json['goods_cnt'],
      mc: Parsing.parseDouble(json['mc'])!,
      delivered: json['delivered'],
      physical: json['physical'],
      paid: json['paid'],
      needScan: json['need_scan']
    );
  }

  Order toDatabaseEnt() {
    return Order(
      id: id,
      buyerId: buyerId,
      deliveryId: deliveryId,
      ord: ord,
      ndoc: ndoc,
      info: info,
      isInc: inc == 1,
      goodsCnt: goodsCnt,
      mc: mc,
      delivered: delivered,
      physical: physical,
      paid: paid,
      needScan: needScan
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    deliveryId,
    ord,
    ndoc,
    info,
    inc,
    goodsCnt,
    mc,
    delivered,
    physical,
    paid,
    needScan
  ];
}
