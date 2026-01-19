part of 'entities.dart';

class ApiBuyerOrderData extends Equatable {
  final List<ApiOrder> orders;
  final List<ApiDebt> debts;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;
  final List<ApiOrderLinePackError> orderLinePackErrors;
  final List<ApiBuyerDeliveryMark> buyerDeliveryMarks;
  final List<ApiTask> tasks;

  const ApiBuyerOrderData({
    required this.debts,
    required this.orders,
    required this.orderLines,
    required this.orderLineCodes,
    required this.orderLinePackErrors,
    required this.buyerDeliveryMarks,
    required this.tasks
  });

  factory ApiBuyerOrderData.fromJson(Map<String, dynamic> json) {
    List<ApiBuyerDeliveryMark> buyerDeliveryMarks = json['buyer_delivery_marks']
      .map<ApiBuyerDeliveryMark>((e) => ApiBuyerDeliveryMark.fromJson(e)).toList();
    List<ApiDebt> debts = json['debts'].map<ApiDebt>((e) => ApiDebt.fromJson(e)).toList();
    List<ApiOrder> orders = json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList();
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();
    List<ApiOrderLinePackError> orderLinePackErrors = json['order_line_pack_errors']
      .map<ApiOrderLinePackError>((e) => ApiOrderLinePackError.fromJson(e)).toList();
    List<ApiTask> tasks = json['tasks'].map<ApiTask>((e) => ApiTask.fromJson(e)).toList();

    return ApiBuyerOrderData(
      debts: debts,
      orders: orders,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes,
      orderLinePackErrors: orderLinePackErrors,
      buyerDeliveryMarks: buyerDeliveryMarks,
      tasks: tasks
    );
  }

  @override
  List<Object?> get props => [
    debts,
    orders,
    orderLines,
    orderLineCodes,
    orderLinePackErrors,
    buyerDeliveryMarks,
    tasks
  ];
}
