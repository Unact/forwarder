import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/api.dart';

class AppError implements Exception {
  final String message;

  AppError(this.message);
}

class AppState extends ChangeNotifier {
  final App app;
  AppData _appData;
  List<Buyer> _buyers = [];
  List<CardPayment> _cardPayments = [];
  List<CashPayment> _cashPayments = [];
  List<Debt> _debts = [];
  List<Order> _orders = [];

  User _user;

  bool get newVersionAvailable {
    String currentVersion = app.version;
    String remoteVersion = user.version;

    return remoteVersion != null && Version.parse(remoteVersion) > Version.parse(currentVersion);
  }

  AppState({@required this.app}) {
    _appData = app.appDataRepo.getAppData();
    _user = app.userRepo.getUser();

    loadData();
  }

  AppData get appData => _appData;
  List<Buyer> get buyers => _buyers;
  List<CardPayment> get cardPayments => _cardPayments;
  List<CashPayment> get cashPayments => _cashPayments;
  List<Debt> get debts => _debts;
  List<Order> get orders => _orders;
  User get user => _user;

  Future<void> loadData() async {
    _buyers = await app.buyerRepo.getBuyers();
    _cardPayments= await app.cardPaymentRepo.getCardPayments();
    _cashPayments= await app.cashPaymentRepo.getCashPayments();
    _debts = await app.debtRepo.getDebts();
    _orders = await app.orderRepo.getOrders();

    notifyListeners();
  }

  Future<void> getData() async {
    await loadUserData();

    try {
      dynamic data = await app.api.getData();

      await _setBuyers(data['buyers']);
      await _setCardPayments(data['cardPayments']);
      await _setCashPayments(data['cashPayments']);
      await _setDebts(data['debts']);
      await _setOrders(data['orders']);

      await _setAppData(AppData(lastSyncTime: DateTime.now()));
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    notifyListeners();
  }

  Future<void> clearData() async {
    await deleteUser();
    await _setBuyers([]);
    await _setCardPayments([]);
    await _setCashPayments([]);
    await _setDebts([]);
    await _setOrders([]);
    await _setAppData(AppData());

    notifyListeners();
  }

  Future<void> _setAppData(AppData appData) async {
    await app.appDataRepo.setAppData(appData);
    _appData = appData;
  }

  Future<void> _setBuyers(List<Buyer> buyers) async {
    _buyers = buyers;
    await app.buyerRepo.reloadBuyers(buyers);
  }

  Future<void> _setCardPayments(List<CardPayment> cardPayments) async {
    _cardPayments = cardPayments;
    await app.cardPaymentRepo.reloadCardPayments(cardPayments);
  }

  Future<void> updateCardPayment(CardPayment updatedCardPayment) async {
    _cardPayments.removeWhere((e) => e.id == updatedCardPayment.id);
    _cardPayments.add(updatedCardPayment);
    await app.cardPaymentRepo.updateCardPayment(updatedCardPayment);
  }

  Future<void> _setCashPayments(List<CashPayment> cashPayments) async {
    _cashPayments = cashPayments;
    await app.cashPaymentRepo.reloadCashPayments(cashPayments);
  }

  Future<void> _setOrders(List<Order> orders) async {
    _orders = orders;
    await app.orderRepo.reloadOrders(orders);
  }

  Future<void> updateOrder(Order updatedOrder) async {
    _orders.removeWhere((e) => e.id == updatedOrder.id);
    _orders.add(updatedOrder);
    await app.orderRepo.updateOrder(updatedOrder);
  }

  Future<void> _setDebts(List<Debt> debts) async {
    _debts = debts;
    await app.debtRepo.reloadDebts(debts);
  }

  Future<void> updateDebt(Debt updatedDebt) async {
    _debts.removeWhere((e) => e.id == updatedDebt.id);
    _debts.add(updatedDebt);
    await app.debtRepo.updateDebt(updatedDebt);
  }

  Future<void> loadUserData() async {
    try {
      User user = await app.api.getUserData();
      await app.userRepo.setUser(user);
      _user = user;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    notifyListeners();
  }

  Future<void> deleteUser() async {
    _user = await app.userRepo.resetUser();
    notifyListeners();
  }

  Future<void> login(String url, String login, String password) async {
    try {
      await app.api.login(url, login, password);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await loadUserData();
  }

  Future<void> logout() async {
    try {
      await app.api.logout();
      await clearData();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> resetPassword(String url, String login) async {
    try {
      await app.api.resetPassword(url, login);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> reverseDay() async {
    try {
      User updatedUser = User(
        id: _user.id,
        username: _user.username,
        email: _user.email,
        salesmanName: _user.salesmanName,
        version: _user.version,
        closed: !_user.closed
      );

      await app.api.closeDay(updatedUser.closed);
      await app.userRepo.setUser(updatedUser);
      _user = updatedUser;

      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<Order> deliveryOrder(Order order, Location location) async {
    Order updatedOrder = Order(
      id: order.id,
      buyerId: order.buyerId,
      ord: order.ord,
      ndoc: order.ndoc,
      info: order.info,
      inc: order.inc,
      goodsCnt: order.goodsCnt,
      mc: order.mc,
      delivered: 1
    );

    try {
      await app.api.deliverOrder(updatedOrder, location);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await updateOrder(updatedOrder);
    notifyListeners();

    return updatedOrder;
  }

  Future<Map<String, dynamic>> getPaymentCredentials() async {
    try {
      return await app.api.getPaymentCredentials();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<List<Debt>> acceptPayment(List<Debt> debts, Map<String, dynamic> transaction, Location location) async {
    List<Debt> updatedDebts = debts.map((e) => Debt(
      id: e.id,
      buyerId: e.buyerId,
      orderId: e.orderId,
      ndoc: e.ndoc,
      orderNdoc: e.orderNdoc,
      ddate: e.ddate,
      orderDdate: e.ddate,
      isCheck: e.isCheck,
      debtSum: e.debtSum,
      orderSum: e.orderSum,
      paidSum: e.paymentSum,
      paymentSum: e.paymentSum
    )).toList();

    try {
      await app.api.acceptPayment(updatedDebts, transaction, location);
      await getData();
      updatedDebts = updatedDebts.map((e) => _debts.firstWhere((debt) => debt.id == e.id));
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    notifyListeners();

    return updatedDebts;
  }

  Future<CardPayment> cancelCardPayment(CardPayment cardPayment) async {
    CardPayment updatedCardPayment = CardPayment(
      id: cardPayment.id,
      buyerId: cardPayment.buyerId,
      orderId: cardPayment.orderId,
      summ: cardPayment.summ,
      ddate: cardPayment.ddate,
      transactionId: cardPayment.transactionId,
      canceled: 1
    );

    try {
      await app.api.cancelCardPayment(updatedCardPayment);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await updateCardPayment(updatedCardPayment);
    notifyListeners();

    return updatedCardPayment;
  }

  Future<void> _reportError(dynamic error, dynamic stackTrace) async {
    await app.reportError(error, stackTrace);
  }
}
