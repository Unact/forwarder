import 'package:drift/drift.dart' show Value;
import 'package:u_app_utils/u_app_utils.dart';
import 'package:geolocator/geolocator.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class TasksRepository extends BaseRepository {
  TasksRepository(super.dataStore, super.api);

  Stream<List<Task>> watchTasksByBuyerId(int buyerId, int deliveryId) {
    return dataStore.tasksDao.watchTasksByBuyerId(buyerId, deliveryId);
  }

  Stream<List<TaskReturnedLine>> watchTaskReturnedLines() {
    return dataStore.tasksDao.watchTaskReturnedLines();
  }

  Stream<List<TaskReturnedLine>> watchTaskReturnedLinesByTaskId(int taskId) {
    return dataStore.tasksDao.watchTaskReturnedLinesByTaskId(taskId);
  }

  Future<void> removeTaskReturnedLineScans(Task task) async {
    await dataStore.tasksDao.updateTaskReturnedLinesByTaskId(
      TaskReturnedLinesCompanion(deliveryScanned: Value(null))
    );
  }

  Future<void> scanTaskReturnedLine(TaskReturnedLine taskReturnedLine) async {
    await dataStore.tasksDao.updateTaskReturnedLine(
      taskReturnedLine.id,
      taskReturnedLine.copyWith(deliveryScanned: Value(DateTime.now())).toCompanion(true)
    );
  }

  Future<void> finishTask(
    Task task,
    List<TaskReturnedLine> taskReturnedLines,
    bool completed,
    Position position
  ) async {
    Map<String, dynamic> location = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'altitude': position.altitude,
      'speed': position.speed,
      'heading': position.heading,
      'point_ts': position.timestamp.toIso8601String()
    };
    List<Map<String, dynamic>> lines = taskReturnedLines.map((e) => {
      'id': e.id,
      'delivery_scanned': e.deliveryScanned?.toIso8601String()
    }).toList();

    try {
      final ApiFinishTaskData data = await api.finishTask(task.id, completed, lines, location);

      await dataStore.transaction(() async {
        await dataStore.tasksDao.loadTasks([data.task.toDatabaseEnt()], false);
        await dataStore.tasksDao.loadTaskReturnedLines(
          data.taskReturnedLines.map((e) => e.toDatabaseEnt()).toList(),
          false
        );
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
