import 'package:drift/drift.dart' show Value;
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class PaymentsRepository extends BaseRepository {
  PaymentsRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<List<CashPayment>> watchCashPayments() {
    return dataStore.paymentsDao.watchCashPayments();
  }

  Stream<List<CardPayment>> watchCardPayments() {
    return dataStore.paymentsDao.watchCardPayments();
  }

  Stream<List<Debt>> watchDebts() {
    return dataStore.paymentsDao.watchDebts();
  }

  Stream<List<Debt>> watchDebtsByBuyerId(int buyerId) {
    return dataStore.paymentsDao.watchDebtsByBuyerId(buyerId);
  }

  Stream<Debt> watchDebtById(int id) {
    return dataStore.paymentsDao.watchDebtById(id);
  }

  Stream<Debt?> watchDebtByOrderId(int orderId) {
    return dataStore.paymentsDao.watchDebtByOrderId(orderId);
  }

  Stream<List<CardPayment>> watchCardPaymentsByBuyerId(int buyerId) {
    return dataStore.paymentsDao.watchCardPaymentsByBuyerId(buyerId);
  }

  Stream<List<CashPayment>> watchCashPaymentsByBuyerId(int buyerId) {
    return dataStore.paymentsDao.watchCashPaymentsByBuyerId(buyerId);
  }

  Future<void> updateDebtPaymentSum(Debt debt, double? newValue) async {
    DebtsCompanion updatedDebt = debt.toCompanion(true).copyWith(paymentSum: Value(newValue));

    await dataStore.paymentsDao.upsertDebt(updatedDebt);
  }

  Future<void> acceptPayment(
    List<Order> orders,
    List<Debt> debts,
    Map<String, dynamic>? transaction,
    Position position
  ) async {
    List<OrdersCompanion> updatedOrders = orders
      .map((e) => e.toCompanion(true).copyWith(paid: const Value(true))).toList();
    List<DebtsCompanion> updatedDebts = debts.map((e) {
      double paidSum = (e.paidSum ?? 0) + e.paymentSum!;

      return e.toCompanion(true).copyWith(
        debtSum: Value(e.debtSum - paidSum),
        paidSum: Value(paidSum)
      );
    }).toList();
    List<Map<String, dynamic>> payments = updatedDebts.map((e) => {
      'id': e.id.value,
      'payment_sum': e.paymentSum.value
    }).toList();
    Map<String, dynamic> location = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'altitude': position.altitude,
      'speed': position.speed,
      'heading': position.heading,
      'point_ts': position.timestamp.toIso8601String()
    };

    try {
      await api.acceptPayment(payments, transaction, location);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.transaction(() async {
      for (var updatedDebt in updatedDebts) {
        await dataStore.paymentsDao.upsertDebt(updatedDebt);
      }

      for (var updatedOrder in updatedOrders) {
        await dataStore.ordersDao.upsertOrder(updatedOrder);
      }
    });
  }

  Future<void> cancelCardPayment(CardPayment cardPayment, Map<String, dynamic> transaction) async {
    Debt paymentDebt = (await dataStore.paymentsDao.watchDebtByOrderId(cardPayment.orderId).first)!;
    CardPaymentsCompanion updatedCardPayment = cardPayment.toCompanion(true).copyWith(canceled: const Value(true));
    DebtsCompanion updatedDebt = paymentDebt.toCompanion(true).copyWith(
      paidSum: const Value(null),
      paymentSum: const Value(null)
    );

    try {
      await api.cancelCardPayment(cardPayment.id, transaction);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.paymentsDao.upsertCardPayment(updatedCardPayment);
    await dataStore.paymentsDao.upsertDebt(updatedDebt);
  }
}
