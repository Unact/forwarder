part of 'entities.dart';

class ApiBuyerOrderData extends Equatable {
  final ApiBuyer buyer;
  final List<ApiOrder> orders;
  final List<ApiDebt> debts;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;
  final List<ApiBuyerDeliveryMark> buyerDeliveryMarks;

  const ApiBuyerOrderData({
    required this.buyer,
    required this.debts,
    required this.orders,
    required this.orderLines,
    required this.orderLineCodes,
    required this.buyerDeliveryMarks
  });

  factory ApiBuyerOrderData.fromJson(Map<String, dynamic> json) {
    ApiBuyer buyer = ApiBuyer.fromJson(json['buyer']);
    List<ApiBuyerDeliveryMark> buyerDeliveryMarks = json['buyer_delivery_marks']
      .map<ApiBuyerDeliveryMark>((e) => ApiBuyerDeliveryMark.fromJson(e)).toList();
    List<ApiDebt> debts = json['debts'].map<ApiDebt>((e) => ApiDebt.fromJson(e)).toList();
    List<ApiOrder> orders = json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList();
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();

    return ApiBuyerOrderData(
      buyer: buyer,
      debts: debts,
      orders: orders,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes,
      buyerDeliveryMarks: buyerDeliveryMarks
    );
  }

  @override
  List<Object?> get props => [
    buyer,
    debts,
    orders,
    orderLines,
    orderLineCodes,
    buyerDeliveryMarks
  ];
}
