part of 'database.dart';

@DriftAccessor(
  tables: [
    Tasks,
    TaskReturnedLines
  ]
)
class TasksDao extends DatabaseAccessor<AppDataStore> with _$TasksDaoMixin {
  TasksDao(super.db);

  Future<void> loadTasks(List<Task> list, [bool clearTable = true]) async {
    await db._loadData(tasks, list, clearTable);
  }

  Future<void> loadTaskReturnedLines(List<TaskReturnedLine> list, [bool clearTable = true]) async {
    await db._loadData(taskReturnedLines, list, clearTable);
  }

  Stream<List<Task>> watchTasksByBuyerId(int buyerId, int deliveryId) {
    return (
      select(tasks)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..where((tbl) => tbl.deliveryId.equals(deliveryId))
        ..orderBy([(u) => OrderingTerm(expression: u.taskTypeName)])
    ).watch();
  }

  Future<List<TaskReturnedLine>> getTaskReturnedLinesByTaskId(int taskId) async {
    return (select(taskReturnedLines)
      ..where((tbl) => tbl.taskId.equals(taskId))).get();
  }

  Future<void> updateTaskReturnedLine(int id, TaskReturnedLinesCompanion taskReturnedLine) async {
    await (update(taskReturnedLines)..where((tbl) => tbl.id.equals(id))).write(taskReturnedLine);
  }

  Future<void> updateTaskReturnedLinesByTaskId(int id, TaskReturnedLinesCompanion taskReturnedLine) async {
    await (update(taskReturnedLines)..where((tbl) => tbl.taskId.equals(id))).write(taskReturnedLine);
  }

  Stream<List<TaskReturnedLine>> watchTaskReturnedLines() {
    return select(taskReturnedLines).watch();
  }

  Stream<List<TaskReturnedLine>> watchTaskReturnedLinesByTaskId(int taskId) {
    return (
      select(taskReturnedLines)
        ..where((tbl) => tbl.taskId.equals(taskId))
    ).watch();
  }
}
