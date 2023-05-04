part of 'entities.dart';

class ApiCardPayment extends Equatable {
  final int id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final String? transactionId;
  final int canceled;

  const ApiCardPayment({
    required this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    this.transactionId,
    required this.canceled
  });

  factory ApiCardPayment.fromJson(dynamic json) {
    return ApiCardPayment(
      id: json['id'],
      buyerId: json['buyer_id'],
      orderId: json['order_id'],
      summ: Parsing.parseDouble(json['summ'])!,
      ddate: Parsing.parseDate(json['ddate'])!,
      transactionId: json['transaction_id'],
      canceled: json['canceled']
    );
  }

  CardPayment toDatabaseEnt() {
    return CardPayment(
      id: id,
      buyerId: buyerId,
      orderId: orderId,
      summ: summ,
      ddate: ddate,
      transactionId: transactionId,
      canceled: canceled == 1
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    orderId,
    summ,
    ddate,
    transactionId,
    canceled
  ];
}
