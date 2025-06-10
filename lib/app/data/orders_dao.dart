part of 'database.dart';

@DriftAccessor(
  tables: [
    Buyers,
    Incomes,
    Recepts,
    Orders,
    OrderLines,
    OrderLineCodes,
    OrderLineStorageCodes
  ]
)
class OrdersDao extends DatabaseAccessor<AppDataStore> with _$OrdersDaoMixin {
  OrdersDao(super.db);

   Future<void> loadBuyers(List<Buyer> list) async {
    await batch((batch) {
      batch.deleteWhere(buyers, (row) => const Constant(true));
      batch.insertAll(buyers, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadOrders(List<Order> list) async {
    await batch((batch) {
      batch.deleteWhere(orders, (row) => const Constant(true));
      batch.insertAll(orders, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadOrderLines(List<OrderLine> list) async {
    await batch((batch) {
      batch.deleteWhere(orderLines, (row) => const Constant(true));
      batch.insertAll(orderLines, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadOrderLineCodes(List<OrderLineCode> list) async {
    await batch((batch) {
      batch.deleteWhere(orderLineCodes, (row) => const Constant(true));
      batch.insertAll(orderLineCodes, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadOrderLineStorageCodes(List<OrderLineStorageCode> list) async {
    await batch((batch) {
      batch.deleteWhere(orderLineStorageCodes, (row) => const Constant(true));
      batch.insertAll(orderLineStorageCodes, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadIncomes(List<Income> list) async {
    await batch((batch) {
      batch.deleteWhere(incomes, (row) => const Constant(true));
      batch.insertAll(incomes, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadRecepts(List<Recept> list) async {
    await batch((batch) {
      batch.deleteWhere(recepts, (row) => const Constant(true));
      batch.insertAll(recepts, list, mode: InsertMode.insertOrReplace);
    });
  }

  Stream<List<Order>> watchOrders() {
    return select(orders).watch();
  }

  Stream<List<OrderLineWithCode>> watchOrderLinesByOrderId(int orderId) {
    final orderLineStream = (select(orderLines)..where((tbl) => tbl.orderId.equals(orderId))).watch();
    final orderLineCodeStream = (select(orderLineCodes)..where((tbl) => tbl.orderId.equals(orderId))).watch();
    final orderLineStorageCodeStream = (
      select(orderLineStorageCodes)..where((tbl) => tbl.orderId.equals(orderId))
    ).watch();

    return Rx.combineLatest3(
      orderLineStream,
      orderLineCodeStream,
      orderLineStorageCodeStream,
      (orderLineRows, orderLineCodeRows, orderLineStorageCodeRows) {
        return orderLineRows.map(((e) {
          return OrderLineWithCode(
            e,
            orderLineCodeRows.where((element) => element.subid == e.subid).toList(),
            orderLineStorageCodeRows.where((element) => element.subid == e.subid).toList()
          );
        })).toList();
      }
    );
  }

  Stream<List<OrderLineCode>> watchOrderLineCodes() {
    return select(orderLineCodes).watch();
  }

  Stream<List<Income>> watchIncomes() {
    return select(incomes).watch();
  }

  Stream<List<Recept>> watchRecepts() {
    return select(recepts).watch();
  }

  Stream<List<Buyer>> watchBuyers() {
    return (select(buyers)..orderBy([(u) => OrderingTerm(expression: u.name)])).watch();
  }

  Stream<List<Order>> watchOrdersByBuyerId(int buyerId) {
    return (
      select(orders)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..orderBy([(u) => OrderingTerm(expression: u.ndoc)])
    ).watch();
  }

  Stream<Order> watchOrderById(int id) {
    return (select(orders)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Future<int> upsertOrder(OrdersCompanion order) {
    return into(orders).insertOnConflictUpdate(order);
  }

  Future<int> upsertOrderLineCode(OrderLineCodesCompanion orderLineCode) {
    return into(orderLineCodes).insertOnConflictUpdate(orderLineCode);
  }

  Future<void> clearOrderLineCodesByOrderId(int orderId) async {
    await (delete(orderLineCodes)..where((tbl) => tbl.orderId.equals(orderId))).go();
  }

  Future<void> clearOrderLineCodesByOrderLineSubid(int orderId, int subid) async {
    await (
      delete(orderLineCodes)
        ..where((tbl) => tbl.orderId.equals(orderId))
        ..where((tbl) => tbl.subid.equals(subid))
    ).go();
  }
}

class OrderLineWithCode {
  final OrderLine orderLine;
  final List<OrderLineCode> orderLineCodes;
  final List<OrderLineStorageCode> orderLineStorageCodes;

  OrderLineWithCode(this.orderLine, this.orderLineCodes, this.orderLineStorageCodes);
}
