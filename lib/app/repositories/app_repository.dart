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
        List<Recept> recepts = data.recepts.map((e) => e.toDatabaseEnt()).toList();
        List<Income> incomes = data.incomes.map((e) => e.toDatabaseEnt()).toList();
        List<CashPayment> cashPayments = data.cashPayments.map((e) => e.toDatabaseEnt()).toList();
        List<Buyer> buyers = data.buyers.map((e) => e.toDatabaseEnt()).toList();
        List<BuyerDeliveryMark> buyerDeliveryMarks = data.buyerDeliveryMarks.map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<OrderLine> orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        List<OrderLineCode> orderLineCodes = data.orderLineCodes.map((e) => e.toDatabaseEnt()).toList();
        List<OrderLinePackError> orderLinePackErrors = data.orderLinePackErrors.map((e) => e.toDatabaseEnt()).toList();
        List<OrderLineStorageCode> orderLineStorageCodes = data.orderLineStorageCodes
          .map((e) => e.toDatabaseEnt()).toList();
        List<Debt> debts = data.debts.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.ordersDao.loadBuyers(buyers);
        await dataStore.ordersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks);
        await dataStore.ordersDao.loadIncomes(incomes);
        await dataStore.ordersDao.loadRecepts(recepts);
        await dataStore.ordersDao.loadOrders(orders);
        await dataStore.ordersDao.loadOrderLines(orderLines);
        await dataStore.ordersDao.loadOrderLineCodes(orderLineCodes);
        await dataStore.ordersDao.loadOrderLinePackErrors(orderLinePackErrors);
        await dataStore.ordersDao.loadOrderLineStorageCodes(orderLineStorageCodes);
        await dataStore.paymentsDao.loadDebts(debts);
        await dataStore.paymentsDao.loadCashPayments(cashPayments);
        await dataStore.updatePref(PrefsCompanion(lastLoadTime: Value(DateTime.now())));
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> syncData() async {
    try {
      for (var buyerDeliveryMark in await dataStore.ordersDao.getBuyerDeliveryMarksForSync()) {
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

              await dataStore.ordersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
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

              await dataStore.ordersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
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
