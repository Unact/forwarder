part of 'database.dart';

@DriftAccessor(
  tables: [
    Buyers,
    Incomes,
    Recepts,
    Orders
  ]
)
class OrdersDao extends DatabaseAccessor<AppDataStore> with _$OrdersDaoMixin {
  OrdersDao(AppDataStore db) : super(db);

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

  Future<List<Order>> getOrders() async {
    return select(orders).get();
  }

  Future<List<Income>> getIncomes() async {
    return select(incomes).get();
  }

  Future<List<Recept>> getRecepts() async {
    return select(recepts).get();
  }

  Future<List<Buyer>> getBuyers() async {
    return (select(buyers)..orderBy([(u) => OrderingTerm(expression: u.name)])).get();
  }

  Future<List<Order>> getOrdersByBuyerId(int buyerId) async {
    return (
      select(orders)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..orderBy([(u) => OrderingTerm(expression: u.ndoc)])
    ).get();
  }

  Future<Order> getOrderById(int id) async {
    return (select(orders)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> upsertOrder(OrdersCompanion order) {
    return into(orders).insertOnConflictUpdate(order);
  }
}
