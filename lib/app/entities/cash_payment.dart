import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/nullify.dart';

class CashPayment extends Equatable {
  final int? id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final int kkmprinted;

  const CashPayment({
    this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    required this.kkmprinted
  });

  bool get isKkmprinted => kkmprinted == 1;

  @override
  List<Object?> get props => [id, buyerId, orderId, summ, ddate, kkmprinted];

  factory CashPayment.fromJson(dynamic json) {
    return CashPayment(
      id: json['id'],
      buyerId: json['buyerId'],
      orderId: json['orderId'],
      summ: Nullify.parseDouble(json['summ'])!,
      ddate: Nullify.parseDate(json['ddate'])!,
      kkmprinted: json['kkmprinted']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'orderId': orderId,
      'summ': summ,
      'ddate': ddate.toIso8601String(),
      'kkmprinted': kkmprinted
    };
  }

  @override
  String toString() => 'CardPayment { id: $id }';
}
