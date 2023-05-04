import 'package:drift/drift.dart' show Value;

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

class PaymentsRepository extends BaseRepository {
  PaymentsRepository(AppDataStore dataStore) : super(dataStore);

  Future<List<CashPayment>> getCashPayments() async {
    return dataStore.paymentsDao.getCashPayments();
  }

  Future<List<CardPayment>> getCardPayments() async {
    return dataStore.paymentsDao.getCardPayments();
  }

  Future<List<Debt>> getDebts() async {
    return dataStore.paymentsDao.getDebts();
  }

  Future<List<Debt>> getDebtsByBuyerId(int buyerId) async {
    return dataStore.paymentsDao.getDebtsByBuyerId(buyerId);
  }

  Future<Debt> getDebtById(int id) async {
    return dataStore.paymentsDao.getDebtById(id);
  }

  Future<List<CardPayment>> getCardPaymentsByBuyerId(int buyerId) async {
    return dataStore.paymentsDao.getCardPaymentsByBuyerId(buyerId);
  }

  Future<List<CashPayment>> getCashPaymentsByBuyerId(int buyerId) async {
    return dataStore.paymentsDao.getCashPaymentsByBuyerId(buyerId);
  }

  Future<void> updateDebtPaymentSum(Debt debt, double? newValue) async {
    DebtsCompanion updatedDebt = debt.toCompanion(true).copyWith(paymentSum: Value(newValue));

    await dataStore.paymentsDao.upsertDebt(updatedDebt);

    notifyListeners();
  }

  Future<void> acceptPayment(List<Debt> debts, Map<String, dynamic>? transaction, Location location) async {
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

    try {
      await api.acceptPayment(payments, transaction, location);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.transaction(() async {
      for (var i = 0; i < updatedDebts.length; i++) {
        await dataStore.paymentsDao.upsertDebt(updatedDebts[i]);
      }
    });

    notifyListeners();
  }

  Future<void> cancelCardPayment(CardPayment cardPayment, Map<String, dynamic> transaction) async {
    Debt paymentDebt = await dataStore.paymentsDao.getDebtByOrderId(cardPayment.orderId);
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

    notifyListeners();
  }
}
