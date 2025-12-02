import 'package:drift/drift.dart' show Value;
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class OrdersRepository extends BaseRepository {
  OrdersRepository(super.dataStore, super.api);

  Stream<List<Income>> watchIncomes() {
    return dataStore.ordersDao.watchIncomes();
  }

  Stream<List<Recept>> watchRecepts() {
    return dataStore.ordersDao.watchRecepts();
  }

  Stream<List<Order>> watchOrders() {
    return dataStore.ordersDao.watchOrders();
  }

  Stream<List<OrderLineCode>> watchOrderLineCodes() {
    return dataStore.ordersDao.watchOrderLineCodes();
  }

  Stream<List<OrderLineStorageCode>> watchOrderLineStorageCodes() {
    return dataStore.ordersDao.watchOrderLineStorageCodes();
  }

  Stream<List<Order>> watchOrdersByBuyerId(int buyerId, int deliveryId) {
    return dataStore.ordersDao.watchOrdersByBuyerId(buyerId, deliveryId);
  }

  Stream<List<OrderLineWithCode>> watchOrderLinesByOrderId(int orderId) {
    return dataStore.ordersDao.watchOrderLinesByOrderId(orderId);
  }

  Stream<Order> watchOrderById(int id) {
    return dataStore.ordersDao.watchOrderById(id);
  }

  Future<void> addOrderLinePackError({
    required OrderLine orderLine,
    required double volume
  }) async {
    OrderLinePackErrorsCompanion newOrderLinePackError = OrderLinePackErrorsCompanion(
      orderId: Value(orderLine.orderId),
      subid: Value(orderLine.subid),
      measureId: Value(orderLine.minMeasureId),
      volume: Value(volume),
      localTs: Value(DateTime.now())
    );

    await dataStore.ordersDao.upsertOrderLinePackError(newOrderLinePackError);
  }

  Future<void> addOrderLineCode({
    required OrderLine orderLine,
    required String code,
    required String? groupCode,
    required int amount,
    required bool isDataMatrix
  }) async {
    OrderLineCodesCompanion newOrderLineCode = OrderLineCodesCompanion(
      orderId: Value(orderLine.orderId),
      subid: Value(orderLine.subid),
      code: Value(code),
      groupCode: Value(groupCode),
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

  Future<void> deliveryOrder(
    Order order,
    bool delivered,
    List<OrderLineCode> orderLineCodes,
    List<OrderLinePackError> orderLinePackErrors,
    Position position
  ) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: Value(delivered));
    List<Map<String, dynamic>> updatedOrderLineCodes = orderLineCodes.map((e) => {
      'subid': e.subid,
      'code': e.code,
      'group_code': e.groupCode,
      'markirovka': e.isDataMatrix,
      'amount': e.amount,
      'local_ts': e.localTs.toIso8601String()
    }).toList();
    List<Map<String, dynamic>> updatedOrderLinePackErrors = orderLinePackErrors.map((e) => {
      'subid': e.subid,
      'volume': e.volume,
      'measure_id': e.measureId,
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
      final ApiOrderDeliveryData data = await api.deliverOrder(
        updatedOrder.id.value,
        updatedOrderLineCodes,
        updatedOrderLinePackErrors,
        delivered,
        location
      );

      await dataStore.transaction(() async {
        final orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        final orderLineCodes = data.orderLineCodes.map((e) => e.toDatabaseEnt()).toList();
        final orderLinePackErrors = data.orderLinePackErrors.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.ordersDao.loadOrders([data.order.toDatabaseEnt()], false);
        await dataStore.ordersDao.loadOrderLines(orderLines, false);
        await dataStore.ordersDao.loadOrderLineCodes(orderLineCodes, false);
        await dataStore.ordersDao.loadOrderLinePackErrors(orderLinePackErrors, false);
        if (data.debt != null) await dataStore.paymentsDao.loadDebts([data.debt!.toDatabaseEnt()], false);
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.ordersDao.upsertOrder(updatedOrder);
  }

  Future<void> cancelOrderDelivery(Order order) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: const Value.absent());

    try {
      final ApiOrderDeliveryData data = await api.cancelOrderDelivery(order.id);

      await dataStore.transaction(() async {
        final orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        final orderLineCodes = data.orderLineCodes.map((e) => e.toDatabaseEnt()).toList();
        final orderLinePackErrors = data.orderLinePackErrors.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.ordersDao.loadOrders([data.order.toDatabaseEnt()], false);
        await dataStore.ordersDao.loadOrderLines(orderLines, false);
        await dataStore.ordersDao.loadOrderLineCodes(orderLineCodes, false);
        await dataStore.ordersDao.loadOrderLinePackErrors(orderLinePackErrors, false);
        if (data.debt != null) await dataStore.paymentsDao.loadDebts([data.debt!.toDatabaseEnt()], false);
      });
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

  Future<void> deleteOrderLinePackErrorByOrderLineSubid(OrderLinePackError packError) async {
    await dataStore.ordersDao.deleteOrderLinePackErrorByOrderLineSubid(packError.orderId, packError.subid);
  }
}
