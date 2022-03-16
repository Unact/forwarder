import 'package:equatable/equatable.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/utils/nullify.dart';

class GetDataResponse extends Equatable {
  final List<Buyer> buyers;
  final List<CardPayment> cardPayments;
  final List<CashPayment> cashPayments;
  final List<Debt> debts;
  final List<Order> orders;
  final List<Income> incomes;
  final List<Recept> recepts;

  const GetDataResponse({
    required this.buyers,
    required this.cardPayments,
    required this.cashPayments,
    required this.debts,
    required this.orders,
    required this.incomes,
    required this.recepts,
  });

  factory GetDataResponse.fromJson(Map<String, dynamic> json) {
    List<Income> incomes = json['incomes']
      .map<Income>((e) => Income.fromJson(e)).toList();
    List<Recept> recepts = json['recepts']
      .map<Recept>((e) => Recept.fromJson(e)).toList();
    List<Buyer> buyers = json['buyers']
      .map<Buyer>((e) => Buyer.fromJson(e)).toList();
    List<CardPayment> cardPayments = json['card_repayments']
      .map<CardPayment>((e) => CardPayment(
        id: e['id'],
        buyerId: e['buyer_id'],
        orderId: e['order_id'],
        summ: Nullify.parseDouble(e['summ'])!,
        ddate: Nullify.parseDate(e['ddate'])!,
        transactionId: e['transaction_id'],
        canceled: Nullify.parseBoolInt(e['canceled'])!
      )).toList();
    List<CashPayment> cashPayments = json['repayments']
      .map<CashPayment>((e) => CashPayment(
        id: e['id'],
        buyerId: e['buyer_id'],
        orderId: e['order_id'],
        summ: Nullify.parseDouble(e['summ'])!,
        ddate: Nullify.parseDate(e['ddate'])!,
        kkmprinted: e['kkmprinted']
      )).toList();
    List<Debt> debts = json['debts']
      .map<Debt>((e) => Debt(
        id: e['id'],
        buyerId: e['buyer_id'],
        orderId: e['order_id'],
        ndoc: e['ndoc'],
        orderNdoc: e['order_ndoc'],
        ddate: Nullify.parseDate(e['ddate'])!,
        orderDdate: Nullify.parseDate(e['order_ddate'])!,
        isCheck: e['is_check'],
        debtSum: Nullify.parseDouble(e['debt_sum'])!,
        orderSum: Nullify.parseDouble(e['order_sum'])!,
        paidSum: Nullify.parseDouble(e['paid_sum'])
      )).toList();
    List<Order> orders = json['orders']
      .map<Order>((e) => Order(
        id: e['id'],
        buyerId: e['buyer_id'],
        ord: e['ord'],
        ndoc: e['ndoc'],
        info: e['info'],
        inc: e['inc'],
        goodsCnt: e['goods_cnt'],
        mc: Nullify.parseDouble(e['mc'])!,
        delivered: Nullify.parseBoolInt(e['delivered'])
      )).toList();

    return GetDataResponse(
      buyers: buyers,
      cardPayments: cardPayments,
      cashPayments: cashPayments,
      debts: debts,
      orders: orders,
      incomes: incomes,
      recepts: recepts
    );
  }

  @override
  List<Object> get props => [
    buyers,
    cardPayments,
    cashPayments,
    debts,
    orders,
  ];
}

class GetUserDataResponse extends Equatable {
  final User user;

  const GetUserDataResponse({
    required this.user
  });

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponse(
      user: User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        salesmanName: json['salesman_name'],
        salesmanNum: json['salesman_num'],
        version: json['app']['version'],
        closed: json['closed'],
        total: Nullify.parseDouble(json['total'])!,
      )
    );
  }

  @override
  List<Object> get props => [
    user
  ];
}

class GetPaymentCredentialsResponse extends Equatable {
  final PaymentCredentials paymentCredentials;

  const GetPaymentCredentialsResponse({
    required this.paymentCredentials
  });

  factory GetPaymentCredentialsResponse.fromJson(Map<String, dynamic> json) {
    return GetPaymentCredentialsResponse(
      paymentCredentials: PaymentCredentials(
        login: json['ibox_login'],
        password: json['ibox_password']
      )
    );
  }

  @override
  List<Object> get props => [
    paymentCredentials
  ];
}
