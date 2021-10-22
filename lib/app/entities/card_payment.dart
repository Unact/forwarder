import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/nullify.dart';

class CardPayment extends Equatable {
  final int? id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final String? transactionId;
  final int canceled;

  const CardPayment({
    this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    this.transactionId,
    required this.canceled
  });

  bool get isCanceled => canceled == 1;

  @override
  List<Object?> get props => [id, buyerId, orderId, summ, ddate, transactionId, canceled];

  factory CardPayment.fromJson(dynamic json) {
    return CardPayment(
      id: json['id'],
      buyerId: json['buyerId'],
      orderId: json['orderId'],
      summ: Nullify.parseDouble(json['summ'])!,
      ddate: Nullify.parseDate(json['ddate'])!,
      transactionId: json['transactionId'],
      canceled: json['canceled']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'orderId': orderId,
      'summ': summ,
      'ddate': ddate.toIso8601String(),
      'transactionId': transactionId,
      'canceled': canceled,
    };
  }

  @override
  String toString() => 'CardPayment { id: $id }';
}
