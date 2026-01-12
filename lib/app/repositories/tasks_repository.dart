import 'package:u_app_utils/u_app_utils.dart';

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

  Future<void> finishTask(Task task) async {

    try {
      final ApiFinishTaskData data = await api.finishTask(task.id);

      await dataStore.transaction(() async {
        await dataStore.tasksDao.loadTasks([data.task.toDatabaseEnt()], false);
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
