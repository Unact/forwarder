part of 'database.dart';

@DriftAccessor(
  tables: [
    Buyers,
    Deliveries,
    BuyerDeliveryMarks,
    BuyerDeliveryPoints,
    BuyerDeliveryPointPhotos,
  ]
)
class BuyersDao extends DatabaseAccessor<AppDataStore> with _$BuyersDaoMixin {
  BuyersDao(super.db);


  Future<int> _generateId(TableInfo table) async {
    final expr = table.rowId.min();
    final query = selectOnly(table)..addColumns([expr]);
    final minId = (await query.getSingle()).read(expr) ?? 0;
    final newId = (minId > 0 ? minId * -1: minId) - 1;

    return newId;
  }

  Future<int> generateBuyerDeliveryPointId() async {
    return _generateId(buyerDeliveryPoints);
  }

  Future<int> generateBuyerDeliveryPointPhotoId() async {
    return _generateId(buyerDeliveryPointPhotos);
  }

  Future<void> loadDeliveries(List<Delivery> list, [bool clearTable = true]) async {
    await db._loadData(deliveries, list, clearTable);
  }

  Future<void> loadBuyers(List<Buyer> list, [bool clearTable = true]) async {
    await db._loadData(buyers, list, clearTable);
  }

  Future<void> loadBuyerDeliveryMarks(List<BuyerDeliveryMark> list, [bool clearTable = true]) async {
    await db._loadData(buyerDeliveryMarks, list, clearTable);
  }

  Future<void> loadBuyerDeliveryPoints(List<BuyerDeliveryPoint> list, [bool clearTable = true]) async {
    await db._loadData(buyerDeliveryPoints, list, clearTable);
  }

  Future<void> loadBuyerDeliveryPointPhotos(List<BuyerDeliveryPointPhoto> list, [bool clearTable = true]) async {
    await db._loadData(buyerDeliveryPointPhotos, list, clearTable);
  }

  Stream<List<Delivery>> watchDeliveries() {
    return select(deliveries).watch();
  }

  Stream<List<BuyerEx>> watchBuyerExList() {
    final buyerStream = (
      select(buyers)
      ..orderBy([
        (u) => OrderingTerm(expression: u.deliveryId),
        (u) => OrderingTerm(expression: u.ord),
        (u) => OrderingTerm(expression: u.name)
      ])
    ).watch();
    final buyerDeliveryMarksStream = select(buyerDeliveryMarks).watch();
    final deliveriesStream = select(deliveries).watch();

    return Rx.combineLatest3(
      buyerStream,
      buyerDeliveryMarksStream,
      deliveriesStream,
      (buyerRows, buyerDeliveryMarkRows, deliveryRows) {
        return buyerRows.map(((e) => BuyerEx(
          e,
          buyerDeliveryMarkRows
            .where((element) => element.deliveryId == e.deliveryId && element.buyerId == e.buyerId).toList(),
          deliveryRows.firstWhere((element) => element.id == e.deliveryId)
        ))).toList();
      }
    );
  }

  Stream<BuyerEx> watchBuyerExById(int buyerId, int deliveryId) {
    final buyerStream = (
      select(buyers)
      ..where((tbl) => tbl.buyerId.equals(buyerId))
      ..where((tbl) => tbl.deliveryId.equals(deliveryId))
    ).watchSingle();
    final buyerDeliveryMarksStream = (
      select(buyerDeliveryMarks)
      ..where((tbl) => tbl.buyerId.equals(buyerId))
      ..where((tbl) => tbl.deliveryId.equals(deliveryId))
    ).watch();
    final deliveryStream = (
      select(deliveries)
      ..where((tbl) => tbl.id.equals(deliveryId))
    ).watchSingle();

    return Rx.combineLatest3(
      buyerStream,
      buyerDeliveryMarksStream,
      deliveryStream,
      (buyerRow, buyerDeliveryMarkRows, deliveryRow) {
        return BuyerEx(buyerRow, buyerDeliveryMarkRows, deliveryRow);
      }
    );
  }

  Stream<BuyerDeliveryPointEx> watchBuyerDeliveryPointExById(int id) {
    final buyerDeliveryPointStream = (
      select(buyerDeliveryPoints)..where((tbl) => tbl.id.equals(id))
    ).watchSingle();
    final buyerDeliveryPointPhotosStream = (
      select(buyerDeliveryPointPhotos)..where((tbl) => tbl.buyerDeliveryPointId.equals(id))
    ).watch();

    return Rx.combineLatest2(
      buyerDeliveryPointStream,
      buyerDeliveryPointPhotosStream,
      (buyerDeliveryPointsRow, buyerDeliveryPointPhotosRows) {
        return BuyerDeliveryPointEx(buyerDeliveryPointsRow, buyerDeliveryPointPhotosRows);
      }
    );
  }

  Future<void> addBuyerDeliveryPoint(BuyerDeliveryPointsCompanion newPoint) async {
    await into(buyerDeliveryPoints).insert(newPoint);
  }

  Future<void> deleteBuyerDeliveryPoint(int id) async {
    await (delete(buyerDeliveryPoints)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> addBuyerDeliveryPointPhoto(BuyerDeliveryPointPhotosCompanion newPointPhoto) async {
    await into(buyerDeliveryPointPhotos).insert(newPointPhoto);
  }

  Future<void> deleteBuyerDeliveryPointPhoto(int id) async {
    await (delete(buyerDeliveryPointPhotos)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateBuyerDeliveryPoint(int id, BuyerDeliveryPointsCompanion updatedPoint) async {
    await (update(buyerDeliveryPoints)..where((tbl) => tbl.id.equals(id))).write(updatedPoint);
  }

  Future<void> updateBuyerDeliveryPointPhoto(int id, BuyerDeliveryPointPhotosCompanion updatedPointPhoto) async {
    await (update(buyerDeliveryPointPhotos)..where((tbl) => tbl.id.equals(id))).write(updatedPointPhoto);
  }

  Future<List<BuyerDeliveryMark>> getBuyerDeliveryMarksForSync() async {
    return (select(buyerDeliveryMarks)..where((tbl) => tbl.id.isNull())).get();
  }

  Future<int> upsertBuyerDeliveryMark(BuyerDeliveryMarksCompanion buyerDeliveryMark) {
    return into(buyerDeliveryMarks).insertOnConflictUpdate(buyerDeliveryMark);
  }

  Future<BuyerDeliveryPointEx?> getBuyerDeliveryPointExByBuyerId(int buyerId) async {
    final buyerDeliveryPointsRes = await (
      select(buyerDeliveryPoints)
      ..where((tbl) => tbl.buyerId.equals(buyerId))
    ).getSingleOrNull();
    final buyerDeliveryPointPhotosRes = await (
      select(buyerDeliveryPointPhotos)
      ..where((tbl) => tbl.buyerDeliveryPointId.equalsNullable(buyerDeliveryPointsRes?.id))
    ).get();

    return buyerDeliveryPointsRes != null ?
      BuyerDeliveryPointEx(buyerDeliveryPointsRes, buyerDeliveryPointPhotosRes) :
      null;
  }

  Future<BuyerDeliveryPointEx> getBuyerDeliveryPointEx(int id) async {
    final buyerDeliveryPointsRes = await (
      select(buyerDeliveryPoints)
      ..where((tbl) => tbl.id.equals(id))
    ).getSingle();
    final buyerDeliveryPointPhotosRes = await (
      select(buyerDeliveryPointPhotos)
      ..where((tbl) => tbl.buyerDeliveryPointId.equals(id))
    ).get();

    return BuyerDeliveryPointEx(buyerDeliveryPointsRes, buyerDeliveryPointPhotosRes);
  }
}

class BuyerEx {
  final Delivery delivery;
  final Buyer buyer;
  final List<BuyerDeliveryMark> buyerDeliveryMarks;

  bool get missed => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.missed);
  bool get arrived => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.arrival);
  bool get departed => buyerDeliveryMarks.any((e) => e.type == BuyerDeliveryMarkType.departure);
  bool get inProgress => arrived && !departed;
  bool get visited => arrived && !missed;

  BuyerEx(this.buyer, this.buyerDeliveryMarks, this.delivery);
}

class BuyerDeliveryPointEx {
  final BuyerDeliveryPoint point;
  final List<BuyerDeliveryPointPhoto> photos;

  BuyerDeliveryPointEx(this.point, this.photos);
}
