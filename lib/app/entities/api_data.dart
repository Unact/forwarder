part of 'entities.dart';

class ApiData extends Equatable {
  final List<ApiBuyer> buyers;
  final List<ApiBuyerDeliveryMark> buyerDeliveryMarks;
  final List<ApiCashPayment> cashPayments;
  final List<ApiDebt> debts;
  final List<ApiOrder> orders;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;
  final List<ApiOrderLinePackError> orderLinePackErrors;
  final List<ApiOrderLineStorageCode> orderLineStorageCodes;
  final List<ApiIncome> incomes;
  final List<ApiRecept> recepts;

  const ApiData({
    required this.buyers,
    required this.buyerDeliveryMarks,
    required this.cashPayments,
    required this.debts,
    required this.orders,
    required this.incomes,
    required this.recepts,
    required this.orderLines,
    required this.orderLineCodes,
    required this.orderLinePackErrors,
    required this.orderLineStorageCodes
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    List<ApiIncome> incomes = json['incomes'].map<ApiIncome>((e) => ApiIncome.fromJson(e)).toList();
    List<ApiRecept> recepts = json['recepts'].map<ApiRecept>((e) => ApiRecept.fromJson(e)).toList();
    List<ApiBuyer> buyers = json['buyers'].map<ApiBuyer>((e) => ApiBuyer.fromJson(e)).toList();
    List<ApiBuyerDeliveryMark> buyerDeliveryMarks = json['buyer_delivery_marks']
      .map<ApiBuyerDeliveryMark>((e) => ApiBuyerDeliveryMark.fromJson(e)).toList();
    List<ApiCashPayment> cashPayments =
      json['repayments'].map<ApiCashPayment>((e) => ApiCashPayment.fromJson(e)).toList();
    List<ApiDebt> debts = json['debts'].map<ApiDebt>((e) => ApiDebt.fromJson(e)).toList();
    List<ApiOrder> orders = json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList();
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();
    List<ApiOrderLinePackError> orderLinePackErrors = json['order_line_pack_errors']
      .map<ApiOrderLinePackError>((e) => ApiOrderLinePackError.fromJson(e)).toList();
    List<ApiOrderLineStorageCode> orderLineStorageCodes = json['order_line_storage_codes']
      .map<ApiOrderLineStorageCode>((e) => ApiOrderLineStorageCode.fromJson(e)).toList();

    return ApiData(
      buyers: buyers,
      buyerDeliveryMarks: buyerDeliveryMarks,
      cashPayments: cashPayments,
      debts: debts,
      orders: orders,
      incomes: incomes,
      recepts: recepts,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes,
      orderLinePackErrors: orderLinePackErrors,
      orderLineStorageCodes: orderLineStorageCodes
    );
  }

  @override
  List<Object> get props => [
    buyers,
    buyerDeliveryMarks,
    cashPayments,
    debts,
    orders,
    incomes,
    recepts,
    orderLines,
    orderLineCodes,
    orderLinePackErrors,
    orderLineStorageCodes
  ];
}
