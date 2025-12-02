import 'package:drift/drift.dart' show Value;
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class AppRepository extends BaseRepository {
  AppRepository(super.dataStore, super.api);

  Stream<AppInfoResult> watchAppInfo() {
    return dataStore.watchAppInfo();
  }

  Future<void> loadData() async {
    try {
      ApiData data = await api.getData();

      await dataStore.transaction(() async {
        final lastLoadTime = DateTime.now();
        final recepts = data.recepts.map((e) => e.toDatabaseEnt()).toList();
        final incomes = data.incomes.map((e) => e.toDatabaseEnt()).toList();
        final cashPayments = data.cashPayments.map((e) => e.toDatabaseEnt()).toList();
        final buyers = data.buyers.map((e) => e.toDatabaseEnt()).toList();
        final buyerDeliveryMarks = data.buyerDeliveryMarks.map((e) => e.toDatabaseEnt()).toList();
        final buyerDeliveryPoints = data.buyerDeliveryPoints.map((e) => e.toDatabaseEnt(lastLoadTime)).toList();
        final buyerDeliveryPointPhotos = data
          .buyerDeliveryPointPhotos.map((e) => e.toDatabaseEnt(lastLoadTime)).toList();
        final orders = data.orders.map((e) => e.toDatabaseEnt()).toList();
        final orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        final orderLineCodes = data.orderLineCodes.map((e) => e.toDatabaseEnt()).toList();
        final orderLinePackErrors = data.orderLinePackErrors.map((e) => e.toDatabaseEnt()).toList();
        final orderLineStorageCodes = data.orderLineStorageCodes.map((e) => e.toDatabaseEnt()).toList();
        final debts = data.debts.map((e) => e.toDatabaseEnt()).toList();
        final deliveries = data.deliveries.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.buyersDao.loadDeliveries(deliveries);
        await dataStore.buyersDao.loadBuyers(buyers);
        await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks);
        await dataStore.buyersDao.loadBuyerDeliveryPoints(buyerDeliveryPoints);
        await dataStore.buyersDao.loadBuyerDeliveryPointPhotos(buyerDeliveryPointPhotos);
        await dataStore.ordersDao.loadIncomes(incomes);
        await dataStore.ordersDao.loadRecepts(recepts);
        await dataStore.ordersDao.loadOrders(orders);
        await dataStore.ordersDao.loadOrderLines(orderLines);
        await dataStore.ordersDao.loadOrderLineCodes(orderLineCodes);
        await dataStore.ordersDao.loadOrderLinePackErrors(orderLinePackErrors);
        await dataStore.ordersDao.loadOrderLineStorageCodes(orderLineStorageCodes);
        await dataStore.paymentsDao.loadDebts(debts);
        await dataStore.paymentsDao.loadCashPayments(cashPayments);
        await dataStore.updatePref(PrefsCompanion(lastLoadTime: Value(lastLoadTime)));
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> syncData() async {
    await syncBuyerDeliveryMarks();
  }

  Future<void> syncBuyerDeliveryMarks() async {
    try {
      for (var buyerDeliveryMark in await dataStore.buyersDao.getBuyerDeliveryMarksForSync()) {
        Map<String, dynamic> location = {
          'latitude': buyerDeliveryMark.latitude,
          'longitude': buyerDeliveryMark.longitude,
          'accuracy': buyerDeliveryMark.accuracy,
          'altitude': buyerDeliveryMark.altitude,
          'speed': buyerDeliveryMark.speed,
          'heading': buyerDeliveryMark.heading,
          'point_ts': buyerDeliveryMark.pointTs.toIso8601String()
        };

        switch (buyerDeliveryMark.type) {
          case BuyerDeliveryMarkType.arrival:
            ApiBuyerDeliveryMarksData data = await api.arrive(
              buyerDeliveryMark.buyerId,
              buyerDeliveryMark.deliveryId,
              location
            );

            await dataStore.transaction(() async {
              List<BuyerDeliveryMark> buyerDeliveryMarks =
                data.buyerDeliveryMarks.map((e) => e.toDatabaseEnt()).toList();

              await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
            });

            break;
          case BuyerDeliveryMarkType.departure:
            ApiBuyerDeliveryMarksData data = await api.depart(
              buyerDeliveryMark.buyerId,
              buyerDeliveryMark.deliveryId,
              location
            );

            await dataStore.transaction(() async {
              List<BuyerDeliveryMark> buyerDeliveryMarks =
                data.buyerDeliveryMarks.map((e) => e.toDatabaseEnt()).toList();

              await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
            });

            break;
          default:
        }
      }
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> clearData() async {
    await dataStore.clearData();
  }
}
