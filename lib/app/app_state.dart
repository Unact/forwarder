import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/repositories/repositories.dart';
import 'package:forwarder/app/services/api.dart';
import 'package:forwarder/app/services/storage.dart';

class AppError implements Exception {
  final String message;

  AppError(this.message);
}

class AppState extends ChangeNotifier {
  final App app;
  late AppData _appData;
  late User _user;
  List<Buyer> _buyers = [];
  List<CardPayment> _cardPayments = [];
  List<CashPayment> _cashPayments = [];
  List<Debt> _debts = [];
  List<Order> _orders = [];
  List<Income> _incomes = [];
  List<Recept> _recepts = [];

  final Api api;
  final AppDataRepository appDataRepo;
  final BuyerRepository buyerRepo;
  final CardPaymentRepository cardPaymentRepo;
  final CashPaymentRepository cashPaymentRepo;
  final DebtRepository debtRepo;
  final OrderRepository orderRepo;
  final UserRepository userRepo;
  final IncomeRepository incomeRepo;
  final ReceptRepository receptRepo;

  bool get newVersionAvailable {
    String currentVersion = app.version;
    String? remoteVersion = user.version;

    return remoteVersion != null && Version.parse(remoteVersion) > Version.parse(currentVersion);
  }

  String get fullVersion => app.version + '+' + app.buildNumber;

  AppState({required this.app}) :
    api = Api.instance!,
    appDataRepo = AppDataRepository(storage: Storage.instance!),
    buyerRepo = BuyerRepository(storage: Storage.instance!),
    cardPaymentRepo = CardPaymentRepository(storage: Storage.instance!),
    cashPaymentRepo = CashPaymentRepository(storage: Storage.instance!),
    debtRepo = DebtRepository(storage: Storage.instance!),
    orderRepo = OrderRepository(storage: Storage.instance!),
    userRepo = UserRepository(storage: Storage.instance!),
    incomeRepo = IncomeRepository(storage: Storage.instance!),
    receptRepo = ReceptRepository(storage: Storage.instance!)
  {
    _appData = appDataRepo.getAppData();
    _user = userRepo.getUser();

    loadData();
  }

  AppData get appData => _appData;
  List<Buyer> get buyers => _buyers;
  List<CardPayment> get cardPayments => _cardPayments;
  List<CashPayment> get cashPayments => _cashPayments;
  List<Debt> get debts => _debts;
  List<Order> get orders => _orders;
  List<Income> get incomes => _incomes;
  List<Recept> get recepts => _recepts;
  User get user => _user;

  Future<void> loadData() async {
    _buyers = await buyerRepo.getBuyers();
    _cardPayments= await cardPaymentRepo.getCardPayments();
    _cashPayments= await cashPaymentRepo.getCashPayments();
    _debts = await debtRepo.getDebts();
    _orders = await orderRepo.getOrders();

    notifyListeners();
  }

  Future<void> getData() async {
    await loadUserData();

    try {
      GetDataResponse data = await api.getData();

      await _setBuyers(data.buyers);
      await _setCardPayments(data.cardPayments);
      await _setCashPayments(data.cashPayments);
      await _setDebts(data.debts);
      await _setOrders(data.orders);
      await _setIncomes(data.incomes);
      await _setRecepts(data.recepts);

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
    await _setIncomes([]);
    await _setRecepts([]);
    await _setAppData(AppData());

    notifyListeners();
  }

  Future<void> _setAppData(AppData appData) async {
    await appDataRepo.setAppData(appData);
    _appData = appData;
  }

  Future<void> _setBuyers(List<Buyer> buyers) async {
    _buyers = buyers;
    await buyerRepo.reloadBuyers(buyers);
  }

  Future<void> _setCardPayments(List<CardPayment> cardPayments) async {
    _cardPayments = cardPayments;
    await cardPaymentRepo.reloadCardPayments(cardPayments);
  }

  Future<void> updateCardPayment(CardPayment updatedCardPayment) async {
    _cardPayments.removeWhere((e) => e.id == updatedCardPayment.id);
    _cardPayments.add(updatedCardPayment);
    await cardPaymentRepo.updateCardPayment(updatedCardPayment);
  }

  Future<void> _setCashPayments(List<CashPayment> cashPayments) async {
    _cashPayments = cashPayments;
    await cashPaymentRepo.reloadCashPayments(cashPayments);
  }

  Future<void> _setOrders(List<Order> orders) async {
    _orders = orders;
    await orderRepo.reloadOrders(orders);
  }

  Future<void> _setIncomes(List<Income> incomes) async {
    _incomes = incomes;
    await incomeRepo.reloadIncomes(incomes);
  }

  Future<void> _setRecepts(List<Recept> recepts) async {
    _recepts = recepts;
    await receptRepo.reloadRecepts(recepts);
  }

  Future<void> updateOrder(Order updatedOrder) async {
    _orders.removeWhere((e) => e.id == updatedOrder.id);
    _orders.add(updatedOrder);
    await orderRepo.updateOrder(updatedOrder);
  }

  Future<void> _setDebts(List<Debt> debts) async {
    _debts = debts;
    await debtRepo.reloadDebts(debts);
  }

  Future<void> updateDebt(Debt updatedDebt) async {
    _debts.removeWhere((e) => e.id == updatedDebt.id);
    _debts.add(updatedDebt);
    await debtRepo.updateDebt(updatedDebt);
  }

  Future<void> loadUserData() async {
    try {
      User user = (await api.getUserData()).user;
      await userRepo.setUser(user);
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
    _user = await userRepo.resetUser();
    notifyListeners();
  }

  Future<void> login(String url, String login, String password) async {
    try {
      await api.login(url, login, password);
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
      await api.logout();
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
      await api.resetPassword(url, login);
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

      await api.closeDay(updatedUser.closed);
      await userRepo.setUser(updatedUser);
      _user = updatedUser;

      notifyListeners();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<Order> deliveryOrder(Order order, bool delivered, Location location) async {
    Order updatedOrder = Order(
      id: order.id,
      buyerId: order.buyerId,
      ord: order.ord,
      ndoc: order.ndoc,
      info: order.info,
      inc: order.inc,
      goodsCnt: order.goodsCnt,
      mc: order.mc,
      delivered: delivered ? 1 : 0
    );

    try {
      await api.deliverOrder(updatedOrder, location);
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

  Future<PaymentCredentials> getPaymentCredentials() async {
    try {
      return (await api.getPaymentCredentials()).paymentCredentials;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> acceptPayment(List<Debt> debts, Map<String, dynamic>? transaction, Location location) async {
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
      paidSum: (e.paidSum ?? 0) + e.paymentSum!,
      paymentSum: e.paymentSum
    )).toList();

    try {
      await api.acceptPayment(updatedDebts, transaction, location);
      await getData();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } on AppError {
      rethrow;
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    notifyListeners();
  }

  Future<CardPayment> cancelCardPayment(CardPayment cardPayment, Map<String, dynamic> transaction) async {
    Debt paymentDebt = _debts.firstWhere((e) => e.orderId == cardPayment.orderId);
    CardPayment updatedCardPayment = CardPayment(
      id: cardPayment.id,
      buyerId: cardPayment.buyerId,
      orderId: cardPayment.orderId,
      summ: cardPayment.summ,
      ddate: cardPayment.ddate,
      transactionId: cardPayment.transactionId,
      canceled: 1
    );
    Debt updatedDebt = Debt(
      id: paymentDebt.id,
      buyerId: paymentDebt.buyerId,
      orderId: paymentDebt.orderId,
      ndoc: paymentDebt.ndoc,
      orderNdoc: paymentDebt.orderNdoc,
      ddate: paymentDebt.ddate,
      orderDdate: paymentDebt.ddate,
      isCheck: paymentDebt.isCheck,
      debtSum: paymentDebt.debtSum,
      orderSum: paymentDebt.orderSum
    );

    try {
      await api.cancelCardPayment(updatedCardPayment, transaction);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      _reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await updateCardPayment(updatedCardPayment);
    await updateDebt(updatedDebt);
    notifyListeners();

    return updatedCardPayment;
  }

  Future<void> _reportError(dynamic error, dynamic stackTrace) async {
    await app.reportError(error, stackTrace);
  }
}
