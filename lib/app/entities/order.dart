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
  final int? delivered;

  const Order({
    required this.id,
    required this.buyerId,
    required this.ord,
    required this.ndoc,
    required this.info,
    required this.inc,
    required this.goodsCnt,
    required this.mc,
    this.delivered,
  });

  bool get isDelivered => didDelivery && delivered == 1;
  bool get isUndelivered => didDelivery && delivered == 0;
  bool get didDelivery => delivered != null;
  bool get isInc => inc == 1;

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
  ];

  factory Order.fromJson(dynamic json) {
    return Order(
      id: json['id'],
      buyerId: json['buyerId'],
      ord: json['ord'],
      ndoc: json['ndoc'],
      info: json['info'],
      inc: json['inc'],
      goodsCnt: json['goodsCnt'],
      mc: Nullify.parseDouble(json['mc'])!,
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
