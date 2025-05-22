part of 'entities.dart';

class ApiData extends Equatable {
  final List<ApiBuyer> buyers;
  final List<ApiCardPayment> cardPayments;
  final List<ApiCashPayment> cashPayments;
  final List<ApiDebt> debts;
  final List<ApiOrder> orders;
  final List<ApiOrderLine> orderLines;
  final List<ApiOrderLineCode> orderLineCodes;
  final List<ApiIncome> incomes;
  final List<ApiRecept> recepts;

  const ApiData({
    required this.buyers,
    required this.cardPayments,
    required this.cashPayments,
    required this.debts,
    required this.orders,
    required this.incomes,
    required this.recepts,
    required this.orderLines,
    required this.orderLineCodes
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    List<ApiIncome> incomes = json['incomes'].map<ApiIncome>((e) => ApiIncome.fromJson(e)).toList();
    List<ApiRecept> recepts = json['recepts'].map<ApiRecept>((e) => ApiRecept.fromJson(e)).toList();
    List<ApiBuyer> buyers = json['buyers'].map<ApiBuyer>((e) => ApiBuyer.fromJson(e)).toList();
    List<ApiCardPayment> cardPayments =
      json['card_repayments'].map<ApiCardPayment>((e) => ApiCardPayment.fromJson(e)).toList();
    List<ApiCashPayment> cashPayments =
      json['repayments'].map<ApiCashPayment>((e) => ApiCashPayment.fromJson(e)).toList();
    List<ApiDebt> debts = json['debts'].map<ApiDebt>((e) => ApiDebt.fromJson(e)).toList();
    List<ApiOrder> orders = json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList();
    List<ApiOrderLine> orderLines = json['order_lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList();
    List<ApiOrderLineCode> orderLineCodes = json['order_line_codes']
      .map<ApiOrderLineCode>((e) => ApiOrderLineCode.fromJson(e)).toList();

    return ApiData(
      buyers: buyers,
      cardPayments: cardPayments,
      cashPayments: cashPayments,
      debts: debts,
      orders: orders,
      incomes: incomes,
      recepts: recepts,
      orderLines: orderLines,
      orderLineCodes: orderLineCodes
    );
  }

  @override
  List<Object> get props => [
    buyers,
    cardPayments,
    cashPayments,
    debts,
    orders,
    incomes,
    recepts,
    orderLines,
    orderLineCodes
  ];
}
