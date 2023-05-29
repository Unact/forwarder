part of 'database.dart';

@DriftAccessor(
  tables: [
    Debts,
    CashPayments,
    CardPayments
  ]
)
class PaymentsDao extends DatabaseAccessor<AppDataStore> with _$PaymentsDaoMixin {
  PaymentsDao(AppDataStore db) : super(db);

  Future<void> loadCashPayments(List<CashPayment> list) async {
    await batch((batch) {
      batch.deleteWhere(cashPayments, (row) => const Constant(true));
      batch.insertAll(cashPayments, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadCardPayments(List<CardPayment> list) async {
    await batch((batch) {
      batch.deleteWhere(cardPayments, (row) => const Constant(true));
      batch.insertAll(cardPayments, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadDebts(List<Debt> list) async {
    await batch((batch) {
      batch.deleteWhere(debts, (row) => const Constant(true));
      batch.insertAll(debts, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<List<CashPayment>> getCashPayments() async {
    return select(cashPayments).get();
  }

  Future<List<CardPayment>> getCardPayments() async {
    return select(cardPayments).get();
  }

  Future<List<Debt>> getDebts() async {
    return select(debts).get();
  }

  Future<Debt?> getDebtByOrderId(int orderId) async {
    return (select(debts)..where((tbl) => tbl.orderId.equals(orderId))).getSingleOrNull();
  }

  Future<Debt> getDebtById(int id) async {
    return (select(debts)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<List<Debt>> getDebtsByBuyerId(int buyerId) async {
    return (
      select(debts)
        ..where((tbl) => tbl.buyerId.equals(buyerId))
        ..orderBy([(u) => OrderingTerm(expression: u.ndoc)])
    ).get();
  }

  Future<List<CashPayment>> getCashPaymentsByBuyerId(int buyerId) async {
    return (select(cashPayments)..where((tbl) => tbl.buyerId.equals(buyerId))).get();
  }

  Future<List<CardPayment>> getCardPaymentsByBuyerId(int buyerId) async {
    return (select(cardPayments)..where((tbl) => tbl.buyerId.equals(buyerId))).get();
  }

  Future<int> upsertCardPayment(CardPaymentsCompanion cardPayment) {
    return into(cardPayments).insertOnConflictUpdate(cardPayment);
  }

  Future<int> upsertDebt(DebtsCompanion debt) {
    return into(debts).insertOnConflictUpdate(debt);
  }
}
