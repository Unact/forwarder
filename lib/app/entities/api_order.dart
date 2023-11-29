part of 'entities.dart';

class ApiOrder extends Equatable {
  final int id;
  final int buyerId;
  final int ord;
  final String ndoc;
  final String info;
  final int inc;
  final int goodsCnt;
  final double mc;
  final bool? delivered;
  final bool physical;
  final bool paid;

  const ApiOrder({
    required this.id,
    required this.buyerId,
    required this.ord,
    required this.ndoc,
    required this.info,
    required this.inc,
    required this.goodsCnt,
    required this.mc,
    this.delivered,
    required this.physical,
    required this.paid
  });

  factory ApiOrder.fromJson(dynamic json) {
    return ApiOrder(
      id: json['id'],
      buyerId: json['buyer_id'],
      ord: json['ord'],
      ndoc: json['ndoc'],
      info: json['info'],
      inc: json['inc'],
      goodsCnt: json['goods_cnt'],
      mc: Parsing.parseDouble(json['mc'])!,
      delivered: json['delivered'],
      physical: json['physical'],
      paid: json['paid']
    );
  }

  Order toDatabaseEnt() {
    return Order(
      id: id,
      buyerId: buyerId,
      ord: ord,
      ndoc: ndoc,
      info: info,
      isInc: inc == 1,
      goodsCnt: goodsCnt,
      mc: mc,
      delivered: delivered,
      physical: physical,
      paid: paid
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    ord,
    ndoc,
    info,
    inc,
    goodsCnt,
    mc,
    delivered,
    physical,
    paid
  ];
}
