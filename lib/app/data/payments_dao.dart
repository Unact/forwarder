part of 'database.dart';

@DriftAccessor(
  tables: [
    Debts,
    CashPayments
  ]
)
class PaymentsDao extends DatabaseAccessor<AppDataStore> with _$PaymentsDaoMixin {
  PaymentsDao(super.db);

  Future<void> loadCashPayments(List<CashPayment> list) async {
    await db._loadData(cashPayments, list);
  }

  Future<void> loadDebts(List<Debt> list, [bool clearTable = true]) async {
    await db._loadData(debts, list, clearTable);
  }

  Stream<List<CashPayment>> watchCashPayments() {
    return select(cashPayments).watch();
  }

  Stream<List<Debt>> watchDebts() {
    return select(debts).watch();
  }

  Stream<List<Debt>> watchDebtsByOrderId(int orderId) {
    return (select(debts)..where((tbl) => tbl.orderId.equals(orderId))).watch();
  }

  Stream<Debt> watchDebtById(int id) {
    return (select(debts)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Stream<List<Debt>> watchDebtsByBuyerId(int buyerId) {
    return (
      select(debts)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..orderBy([(u) => OrderingTerm(expression: u.ndoc)])
    ).watch();
  }

  Stream<List<CashPayment>> watchCashPaymentsByBuyerId(int buyerId) {
    return (select(cashPayments)..where((tbl) => tbl.buyerId.equals(buyerId))).watch();
  }

  Future<int> upsertDebt(DebtsCompanion debt) {
    return into(debts).insertOnConflictUpdate(debt);
  }
}
