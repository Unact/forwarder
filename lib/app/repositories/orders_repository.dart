import 'package:drift/drift.dart' show Value;

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

class OrdersRepository extends BaseRepository {
  OrdersRepository(AppDataStore dataStore, Api api) : super(dataStore, api);

  Future<List<Buyer>> getBuyers() async {
    return dataStore.ordersDao.getBuyers();
  }

  Future<List<Income>> getIncomes() async {
    return dataStore.ordersDao.getIncomes();
  }

  Future<List<Recept>> getRecepts() async {
    return dataStore.ordersDao.getRecepts();
  }

  Future<List<Order>> getOrders() async {
    return dataStore.ordersDao.getOrders();
  }

  Future<List<Order>> getOrdersByBuyerId(int buyerId) async {
    return dataStore.ordersDao.getOrdersByBuyerId(buyerId);
  }

  Future<List<OrderLineWithCode>> getOrderLinesByOrderId(int orderId) async {
    return dataStore.ordersDao.getOrderLinesByOrderId(orderId);
  }

  Future<Order> getOrderById(int id) async {
    return dataStore.ordersDao.getOrderById(id);
  }

  Future<void> addOrderLineCode({
    required OrderLine orderLine,
    required String code,
    required int amount,
    required bool isDataMatrix
  }) async {
    OrderLineCodesCompanion newOrderLineCode = OrderLineCodesCompanion(
      orderId: Value(orderLine.orderId),
      subid: Value(orderLine.subid),
      code: Value(code),
      amount: Value(amount),
      isDataMatrix: Value(isDataMatrix),
      localTs: Value(DateTime.now())
    );

    await dataStore.ordersDao.upsertOrderLineCode(newOrderLineCode);
    notifyListeners();
  }

  Future<void> updateOrderLineCode({
    required OrderLineCode orderLineCode,
    required int amount
  }) async {
    OrderLineCodesCompanion updatedOrderLineCode = orderLineCode.toCompanion(false).copyWith(amount: Value(amount));

    await dataStore.ordersDao.upsertOrderLineCode(updatedOrderLineCode);
    notifyListeners();
  }

  Future<void> deliveryOrder(Order order, bool delivered, List<OrderLineCode> orderLineCodes, Location location) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: Value(delivered));
    List<Map<String, dynamic>> updatedOrderLineCodes = orderLineCodes.map((e) => {
      'subid': e.subid,
      'code': e.code,
      'markirovka': e.isDataMatrix,
      'amount': e.amount,
      'local_ts': e.localTs.toIso8601String()
    }).toList();

    try {
      await api.deliverOrder(
        updatedOrder.id.value,
        updatedOrderLineCodes,
        delivered,
        location
      );
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.ordersDao.upsertOrder(updatedOrder);
    await dataStore.ordersDao.clearOrderLineCodesByOrderId(order.id);
    notifyListeners();
  }

  Future<void> clearOrderLineCodesByOrderLineSubid(OrderLine orderLine) async {
    await dataStore.ordersDao.clearOrderLineCodesByOrderLineSubid(orderLine.orderId, orderLine.subid);
    notifyListeners();
  }
}
