part of 'entities.dart';

class ApiDeliveryData extends Equatable {
  final ApiOrder order;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;

  const ApiDeliveryData({
    required this.order,
    required this.orderLines,
    required this.orderLineCodes
  });

  factory ApiDeliveryData.fromJson(Map<String, dynamic> json) {
    ApiOrder order = ApiOrder.fromJson(json['order']);
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();

    return ApiDeliveryData(
      order: order,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes
    );
  }

  @override
  List<Object> get props => [
    order,
    orderLines,
    orderLineCodes
  ];
}
