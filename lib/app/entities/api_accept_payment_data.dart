part of 'entities.dart';

class ApiAcceptPaymentData extends Equatable {
  final List<ApiCashPayment> cashPayments;
  final List<ApiIncome> incomes;
  final List<ApiRecept> recepts;

  const ApiAcceptPaymentData({
    required this.cashPayments,
    required this.incomes,
    required this.recepts
  });

  factory ApiAcceptPaymentData.fromJson(Map<String, dynamic> json) {
    List<ApiIncome> incomes = json['incomes'].map<ApiIncome>((e) => ApiIncome.fromJson(e)).toList();
    List<ApiRecept> recepts = json['recepts'].map<ApiRecept>((e) => ApiRecept.fromJson(e)).toList();
    List<ApiCashPayment> cashPayments =
      json['repayments'].map<ApiCashPayment>((e) => ApiCashPayment.fromJson(e)).toList();

    return ApiAcceptPaymentData(
      cashPayments: cashPayments,
      incomes: incomes,
      recepts: recepts,
    );
  }

  @override
  List<Object> get props => [
    cashPayments,
    incomes,
    recepts,
  ];
}
