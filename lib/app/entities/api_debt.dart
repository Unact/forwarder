part of 'entities.dart';

class ApiDebt extends Equatable {
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
  final bool physical;

  const ApiDebt({
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
    this.paymentSum,
    required this.physical
  });

  factory ApiDebt.fromJson(dynamic json) {
    return ApiDebt(
      id: json['id'],
      buyerId: json['buyer_id'],
      orderId: json['order_id'],
      ndoc: json['ndoc'],
      orderNdoc: json['order_ndoc'],
      ddate: Parsing.parseDate(json['ddate'])!,
      orderDdate: Parsing.parseDate(json['order_ddate'])!,
      isCheck: json['is_check'],
      debtSum: Parsing.parseDouble(json['debt_sum'])!,
      orderSum: Parsing.parseDouble(json['order_sum'])!,
      paidSum: Parsing.parseDouble(json['paid_sum']),
      paymentSum: Parsing.parseDouble(json['payment_sum']),
      physical: json['physical']
    );
  }

  Debt toDatabaseEnt() {
    return Debt(
      id: id,
      buyerId: buyerId,
      orderId: orderId,
      ndoc: ndoc,
      orderNdoc: orderNdoc,
      ddate: ddate,
      orderDdate: orderDdate,
      isCheck: isCheck == 1,
      debtSum: debtSum,
      orderSum: orderSum,
      paidSum: paidSum,
      paymentSum: paymentSum,
      physical: physical
    );
  }

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
    paymentSum,
    physical
  ];
}
