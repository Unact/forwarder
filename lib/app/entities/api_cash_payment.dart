part of 'entities.dart';

class ApiCashPayment extends Equatable {
  final int id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final int kkmprinted;

  const ApiCashPayment({
    required this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    required this.kkmprinted
  });

  factory ApiCashPayment.fromJson(dynamic json) {
    return ApiCashPayment(
      id: json['id'],
      buyerId: json['buyer_id'],
      orderId: json['order_id'],
      summ: Parsing.parseDouble(json['summ'])!,
      ddate: Parsing.parseDate(json['ddate'])!,
      kkmprinted: json['kkmprinted']
    );
  }

  CashPayment toDatabaseEnt() {
    return CashPayment(
      id: id,
      buyerId: buyerId,
      orderId: orderId,
      summ: summ,
      ddate: ddate,
      kkmprinted: kkmprinted == 1
    );
  }

  @override
  List<Object?> get props => [
    id,
    buyerId,
    orderId,
    summ,
    ddate,
    kkmprinted
  ];
}
