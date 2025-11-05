part of 'entities.dart';

class ApiDeliveryData extends Equatable {
  final ApiOrder order;
  final ApiDebt? debt;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;
  final List<ApiOrderLinePackError> orderLinePackErrors;

  const ApiDeliveryData({
    required this.order,
    required this.debt,
    required this.orderLines,
    required this.orderLineCodes,
    required this.orderLinePackErrors
  });

  factory ApiDeliveryData.fromJson(Map<String, dynamic> json) {
    ApiOrder order = ApiOrder.fromJson(json['order']);
    ApiDebt? debt = json['debt'] != null ? ApiDebt.fromJson(json['debt']) : null;
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();
    List<ApiOrderLinePackError> orderLinePackErrors = json['order_line_pack_errors']
      .map<ApiOrderLinePackError>((e) => ApiOrderLinePackError.fromJson(e)).toList();

    return ApiDeliveryData(
      order: order,
      debt: debt,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes,
      orderLinePackErrors: orderLinePackErrors
    );
  }

  @override
  List<Object?> get props => [
    order,
    debt,
    orderLines,
    orderLineCodes,
    orderLinePackErrors
  ];
}
