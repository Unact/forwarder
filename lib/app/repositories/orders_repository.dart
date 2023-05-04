import 'package:drift/drift.dart' show Value;

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

class OrdersRepository extends BaseRepository {
  OrdersRepository(AppDataStore dataStore) : super(dataStore);

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

  Future<Order> getOrderById(int id) async {
    return dataStore.ordersDao.getOrderById(id);
  }

  Future<void> deliveryOrder(Order order, bool delivered, Location location) async {
    OrdersCompanion updatedOrder = order.toCompanion(false).copyWith(delivered: Value(delivered));

    try {
      await api.deliverOrder(updatedOrder.id.value, delivered, location);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.ordersDao.upsertOrder(updatedOrder);
    notifyListeners();
  }
}
