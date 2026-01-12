part of 'database.dart';

@DriftAccessor(
  tables: [
    Tasks
  ]
)
class TasksDao extends DatabaseAccessor<AppDataStore> with _$TasksDaoMixin {
  TasksDao(super.db);

  Future<void> loadTasks(List<Task> list, [bool clearTable = true]) async {
    await db._loadData(tasks, list, clearTable);
  }

  Stream<List<Task>> watchTasksByBuyerId(int buyerId, int deliveryId) {
    return (
      select(tasks)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..where((tbl) => tbl.deliveryId.equals(deliveryId))
        ..orderBy([(u) => OrderingTerm(expression: u.taskTypeName)])
    ).watch();
  }
}
