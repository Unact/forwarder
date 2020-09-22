import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/nullify.dart';

class Order extends Equatable {
  final int id;
  final int buyerId;
  final int ord;
  final String ndoc;
  final String info;
  final int inc;
  final int goodsCnt;
  final double mc;
  final int delivered;

  const Order({
    this.id,
    this.buyerId,
    this.ord,
    this.ndoc,
    this.info,
    this.inc,
    this.goodsCnt,
    this.mc,
    this.delivered,
  });

  bool get isDelivered => delivered == 1;
  bool get isInc => inc == 1;

  @override
  List<Object> get props => [
    id,
    buyerId,
    ord,
    ndoc,
    info,
    inc,
    goodsCnt,
    mc,
    delivered,
  ];

  static Order fromJson(dynamic json) {
    return Order(
      id: json['id'],
      buyerId: json['buyerId'],
      ord: json['ord'],
      ndoc: json['ndoc'],
      info: json['info'],
      inc: json['inc'],
      goodsCnt: json['goodsCnt'],
      mc: Nullify.parseDouble(json['mc']),
      delivered: json['delivered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'ord': ord,
      'ndoc': ndoc,
      'info': info,
      'inc': inc,
      'goodsCnt': goodsCnt,
      'mc': mc,
      'delivered': delivered,
    };
  }

  @override
  String toString() => 'Order { id: $id }';
}
