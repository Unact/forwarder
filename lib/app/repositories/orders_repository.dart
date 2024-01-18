import 'package:drift/drift.dart' show Value;
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class OrdersRepository extends BaseRepository {
  OrdersRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<List<Buyer>> watchBuyers() {
    return dataStore.ordersDao.watchBuyers();
  }

  Stream<List<Income>> watchIncomes() {
    return dataStore.ordersDao.watchIncomes();
  }

  Stream<List<Recept>> watchRecepts() {
    return dataStore.ordersDao.watchRecepts();
  }

  Stream<List<Order>> watchOrders() {
    return dataStore.ordersDao.watchOrders();
  }

  Stream<List<Order>> watchOrdersByBuyerId(int buyerId) {
    return dataStore.ordersDao.watchOrdersByBuyerId(buyerId);
  }

  Stream<List<OrderLineWithCode>> watchOrderLinesByOrderId(int orderId) {
    return dataStore.ordersDao.watchOrderLinesByOrderId(orderId);
  }

  Stream<Order> watchOrderById(int id) {
    return dataStore.ordersDao.watchOrderById(id);
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
  }

  Future<void> updateOrderLineCode({
    required OrderLineCode orderLineCode,
    required int amount
  }) async {
    OrderLineCodesCompanion updatedOrderLineCode = orderLineCode.toCompanion(false).copyWith(amount: Value(amount));

    await dataStore.ordersDao.upsertOrderLineCode(updatedOrderLineCode);
  }

  Future<void> deliveryOrder(Order order, bool delivered, List<OrderLineCode> orderLineCodes, Position position) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: Value(delivered));
    List<Map<String, dynamic>> updatedOrderLineCodes = orderLineCodes.map((e) => {
      'subid': e.subid,
      'code': e.code,
      'markirovka': e.isDataMatrix,
      'amount': e.amount,
      'local_ts': e.localTs.toIso8601String()
    }).toList();
    Map<String, dynamic> location = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'altitude': position.altitude,
      'speed': position.speed,
      'heading': position.heading,
      'point_ts': position.timestamp.toIso8601String()
    };

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
  }

  Future<void> cancelOrderDelivery(Order order) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: const Value.absent());

    try {
      await api.cancelOrderDelivery(order.id);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.ordersDao.upsertOrder(updatedOrder);
    await dataStore.ordersDao.clearOrderLineCodesByOrderId(order.id);
  }

  Future<void> clearOrderLineCodesByOrderLineSubid(OrderLine orderLine) async {
    await dataStore.ordersDao.clearOrderLineCodesByOrderLineSubid(orderLine.orderId, orderLine.subid);
  }
}
