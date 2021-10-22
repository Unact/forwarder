import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/format.dart';
import 'package:forwarder/app/utils/nullify.dart';

class Debt extends Equatable {
  final int id;
  final int buyerId;
  final int orderId;
  final String ndoc;
  final String orderNdoc;
  final DateTime ddate;
  final DateTime orderDdate;
  final int isCheck;
  final double debtSum;
  final double orderSum;
  final double? paidSum;
  final double? paymentSum;

  const Debt({
    required this.id,
    required this.buyerId,
    required this.orderId,
    required this.ndoc,
    required this.orderNdoc,
    required this.ddate,
    required this.orderDdate,
    required this.isCheck,
    required this.debtSum,
    required this.orderSum,
    this.paidSum,
    this.paymentSum
  });

  bool get needCheck => isCheck == 1;
  String get orderName => orderNdoc + ' от ' + Format.dateStr(orderDdate);
  String get fullname => ndoc + ' от ' + Format.dateStr(ddate) + ' (' + orderNdoc + ')';

  @override
  List<Object?> get props => [
    id,
    buyerId,
    orderId,
    ndoc,
    orderNdoc,
    ddate,
    orderDdate,
    isCheck,
    debtSum,
    orderSum,
    paidSum,
    paymentSum
  ];

  factory Debt.fromJson(dynamic json) {
    return Debt(
      id: json['id'],
      buyerId: json['buyerId'],
      orderId: json['orderId'],
      ndoc: json['ndoc'],
      orderNdoc: json['orderNdoc'],
      ddate: Nullify.parseDate(json['ddate'])!,
      orderDdate: Nullify.parseDate(json['orderDdate'])!,
      isCheck: json['isCheck'],
      debtSum: Nullify.parseDouble(json['debtSum'])!,
      orderSum: Nullify.parseDouble(json['orderSum'])!,
      paidSum: Nullify.parseDouble(json['paidSum']),
      paymentSum: Nullify.parseDouble(json['paymentSum']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'orderId': orderId,
      'ndoc': ndoc,
      'orderNdoc': orderNdoc,
      'ddate': ddate.toIso8601String(),
      'orderDdate': orderDdate.toIso8601String(),
      'isCheck': isCheck,
      'debtSum': debtSum,
      'orderSum': orderSum,
      'paidSum': paidSum,
      'paymentSum': paymentSum
    };
  }

  @override
  String toString() => 'Debt { id: $id }';
}
