part of 'database.dart';

@DriftAccessor(
  tables: [
    Buyers,
    Incomes,
    Recepts,
    Orders,
    OrderLines,
    OrderLineCodes,
    OrderLineStorageCodes,
    OrderLinePackErrors,
    BuyerDeliveryMarks
  ]
)
class OrdersDao extends DatabaseAccessor<AppDataStore> with _$OrdersDaoMixin {
  OrdersDao(super.db);

  Future<void> loadBuyers(List<Buyer> list, [bool clearTable = true]) async {
    await db._loadData(buyers, list, clearTable);
  }

  Future<void> loadBuyerDeliveryMarks(List<BuyerDeliveryMark> list, [bool clearTable = true]) async {
    await db._loadData(buyerDeliveryMarks, list, clearTable);
  }

  Future<void> loadOrders(List<Order> list, [bool clearTable = true]) async {
    await db._loadData(orders, list, clearTable);
  }

  Future<void> loadOrderLines(List<OrderLine> list, [bool clearTable = true]) async {
    await db._loadData(orderLines, list, clearTable);
  }

  Future<void> loadOrderLineCodes(List<OrderLineCode> list, [bool clearTable = true]) async {
    await db._loadData(orderLineCodes, list, clearTable);
  }

  Future<void> loadOrderLinePackErrors(List<OrderLinePackError> list, [bool clearTable = true]) async {
    await db._loadData(orderLinePackErrors, list, clearTable);
  }

  Future<void> loadOrderLineStorageCodes(List<OrderLineStorageCode> list) async {
    await db._loadData(orderLineStorageCodes, list);
  }

  Future<void> loadIncomes(List<Income> list) async {
    await db._loadData(incomes, list);
  }

  Future<void> loadRecepts(List<Recept> list) async {
    await db._loadData(recepts, list);
  }

  Stream<List<Order>> watchOrders() {
    return select(orders).watch();
  }

  Stream<List<OrderLineWithCode>> watchOrderLinesByOrderId(int orderId) {
    final orderLineStream = (select(orderLines)..where((tbl) => tbl.orderId.equals(orderId))).watch();
    final orderLineCodeStream = (select(orderLineCodes)..where((tbl) => tbl.orderId.equals(orderId))).watch();
    final orderLinePackErrorStream = (select(orderLinePackErrors)..where((tbl) => tbl.orderId.equals(orderId))).watch();
    final orderLineStorageCodeStream = (
      select(orderLineStorageCodes)..where((tbl) => tbl.orderId.equals(orderId))
    ).watch();

    return Rx.combineLatest4(
      orderLineStream,
      orderLineCodeStream,
      orderLinePackErrorStream,
      orderLineStorageCodeStream,
      (orderLineRows, orderLineCodeRows, orderLinePackErrorRows, orderLineStorageCodeRows) {
        return orderLineRows.map(((e) {
          return OrderLineWithCode(
            e,
            orderLineCodeRows.where((element) => element.subid == e.subid).toList(),
            orderLinePackErrorRows.where((element) => element.subid == e.subid).toList(),
            orderLineStorageCodeRows.where((element) => element.subid == e.subid).toList()
          );
        })).toList();
      }
    );
  }

  Stream<List<OrderLineCode>> watchOrderLineCodes() {
    return select(orderLineCodes).watch();
  }

  Stream<List<OrderLineStorageCode>> watchOrderLineStorageCodes() {
    return select(orderLineStorageCodes).watch();
  }

  Stream<List<Income>> watchIncomes() {
    return select(incomes).watch();
  }

  Stream<List<Recept>> watchRecepts() {
    return select(recepts).watch();
  }

  Stream<List<BuyerEx>> watchBuyerExList() {
    final buyerStream = (
      select(buyers)
      ..orderBy([
        (u) => OrderingTerm(expression: u.deliveryNdoc),
        (u) => OrderingTerm(expression: u.ord),
        (u) => OrderingTerm(expression: u.name)
      ])
    ).watch();
    final buyerDeliveryMarksStream = select(buyerDeliveryMarks).watch();

    return Rx.combineLatest2(
      buyerStream,
      buyerDeliveryMarksStream,
      (buyerRows, buyerDeliveryMarkRows) {
        return buyerRows.map(((e) => BuyerEx(
          e,
          buyerDeliveryMarkRows
            .where((element) => element.deliveryId == e.deliveryId && element.buyerId == e.buyerId).toList(),
        ))).toList();
      }
    );
  }

  Stream<BuyerEx> watchBuyerExById(int buyerId, int deliveryId) {
    final buyerStream = (
      select(buyers)
      ..where((tbl) => tbl.buyerId.equals(buyerId))
      ..where((tbl) => tbl.deliveryId.equals(deliveryId))
    ).watchSingle();
    final buyerDeliveryMarksStream = (
      select(buyerDeliveryMarks)
      ..where((tbl) => tbl.buyerId.equals(buyerId))
      ..where((tbl) => tbl.deliveryId.equals(deliveryId))
    ).watch();

    return Rx.combineLatest2(
      buyerStream,
      buyerDeliveryMarksStream,
      (buyerRow, buyerDeliveryMarkRows) {
        return BuyerEx(buyerRow, buyerDeliveryMarkRows);
      }
    );
  }

  Stream<List<Order>> watchOrdersByBuyerId(int buyerId, int deliveryId) {
    return (
      select(orders)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..where((tbl) => tbl.deliveryId.equals(deliveryId))
        ..orderBy([(u) => OrderingTerm(expression: u.ndoc)])
    ).watch();
  }

  Stream<Order> watchOrderById(int id) {
    return (select(orders)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Future<List<BuyerDeliveryMark>> getBuyerDeliveryMarksForSync() async {
    return (select(buyerDeliveryMarks)..where((tbl) => tbl.id.isNull())).get();
  }

  Future<int> upsertBuyerDeliveryMark(BuyerDeliveryMarksCompanion buyerDeliveryMark) {
    return into(buyerDeliveryMarks).insertOnConflictUpdate(buyerDeliveryMark);
  }

  Future<int> upsertOrder(OrdersCompanion order) {
    return into(orders).insertOnConflictUpdate(order);
  }

  Future<int> upsertOrderLineCode(OrderLineCodesCompanion orderLineCode) {
    return into(orderLineCodes).insertOnConflictUpdate(orderLineCode);
  }

  Future<int> upsertOrderLinePackError(OrderLinePackErrorsCompanion orderLinePackError) {
    return into(orderLinePackErrors).insertOnConflictUpdate(orderLinePackError);
  }

  Future<void> deleteOrderLinePackErrorByOrderLineSubid(int orderId, int subid) async {
    await (
      delete(orderLinePackErrors)
        ..where((tbl) => tbl.orderId.equals(orderId))
        ..where((tbl) => tbl.subid.equals(subid))
    ).go();
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
  final List<OrderLinePackError> orderLinePackErrors;

  OrderLineWithCode(
    this.orderLine,
    this.orderLineCodes,
    this.orderLinePackErrors,
    this.orderLineStorageCodes
  );
}

class BuyerEx {
  final Buyer buyer;
  final List<BuyerDeliveryMark> buyerDeliveryMarks;

  bool get missed => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.missed);
  bool get arrived => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.arrival);
  bool get departed => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.departure);
  bool get inProgress => arrived && !departed;
  bool get visited => arrived && !missed;

  BuyerEx(this.buyer, this.buyerDeliveryMarks);
}
