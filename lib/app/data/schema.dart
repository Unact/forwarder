part of 'database.dart';

mixin Syncable on Table {
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncTime => dateTime().nullable()();
  BoolColumn get needSync => boolean()
    .generatedAs((isNew & isDeleted.not()) | (isNew.not() & lastSyncTime.isSmallerThan(timestamp)), stored: true)();
  BoolColumn get isNew => boolean().generatedAs(lastSyncTime.isNull())();
}

class Prefs extends Table {
  DateTimeColumn get lastLoadTime => dateTime().nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get salesmanName => text()();
  TextColumn get email => text()();
  BoolColumn get closed => boolean()();
  TextColumn get version => text()();
  RealColumn get total => real()();
}

class Recepts extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get ddate => dateTime()();
  RealColumn get summ => real()();
}

class Incomes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get ddate => dateTime()();
  RealColumn get summ => real()();
}

class Deliveries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ndoc => text()();
  DateTimeColumn get ddateb => dateTime().nullable()();
}

class Buyers extends Table {
  IntColumn get buyerId => integer()();
  IntColumn get deliveryId => integer()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  IntColumn get ord => integer()();
  BoolColumn get needInc => boolean()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  @override
  Set<Column> get primaryKey => {buyerId, deliveryId};
}

class BuyerDeliveryMarks extends Table {
  IntColumn get id => integer().nullable()();
  IntColumn get buyerId => integer()();
  IntColumn get deliveryId => integer()();
  TextColumn get type => textEnum<BuyerDeliveryMarkType>()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracy => real()();
  RealColumn get altitude => real()();
  RealColumn get heading => real()();
  RealColumn get speed => real()();
  DateTimeColumn get pointTs => dateTime()();

  @override
  Set<Column> get primaryKey => {buyerId, deliveryId, type};
}

class BuyerDeliveryPoints extends Table with Syncable {
  IntColumn get id => integer()();
  IntColumn get buyerId => integer()();
  TextColumn get phone => text().nullable()();
  TextColumn get info => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BuyerDeliveryPointPhotos extends Table with Syncable {
  IntColumn get id => integer()();
  IntColumn get buyerDeliveryPointId => integer()();
  TextColumn get url => text()();
  TextColumn get key => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class CashPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer()();
  IntColumn get orderId => integer()();
  RealColumn get summ => real()();
  DateTimeColumn get ddate => dateTime()();
  BoolColumn get kkmprinted => boolean()();
}

class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer()();
  IntColumn get orderId => integer()();
  TextColumn get ndoc => text()();
  TextColumn get orderNdoc => text()();
  DateTimeColumn get ddate => dateTime()();
  DateTimeColumn get orderDdate => dateTime()();
  BoolColumn get isCheck => boolean()();
  RealColumn get debtSum => real()();
  RealColumn get orderSum => real()();
  RealColumn get paidSum => real().nullable()();
  RealColumn get paymentSum => real().nullable()();
  BoolColumn get physical => boolean()();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer()();
  IntColumn get deliveryId => integer()();
  IntColumn get ord => integer()();
  TextColumn get ndoc => text()();
  TextColumn get info => text()();
  BoolColumn get isInc => boolean()();
  IntColumn get goodsCnt => integer()();
  RealColumn get mc => real()();
  BoolColumn get delivered => boolean().nullable()();
  BoolColumn get paid => boolean()();
  BoolColumn get physical => boolean()();
  BoolColumn get needScan => boolean()();
  BoolColumn get dovUnload => boolean()();
}

class OrderLines extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get name => text()();
  TextColumn get gtin => text()();
  RealColumn get vol => real()();
  RealColumn get deliveredVol => real()();
  RealColumn get price => real()();
  BoolColumn get needMarking => boolean()();
  IntColumn get minMeasureId => integer()();
  TextColumn get barcodeRels => text().map(const OrderLineBarcodeListConverter())();

  @override
  Set<Column> get primaryKey => {orderId, subid};
}

class OrderLineCodes extends Table {
  IntColumn get id => integer().nullable()();
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get code => text()();
  IntColumn get amount => integer()();
  BoolColumn get isDataMatrix => boolean()();
  TextColumn get groupCode => text().nullable()();
  DateTimeColumn get localTs => dateTime()();

  @override
  Set<Column> get primaryKey => {orderId, subid, code};
}

class OrderLinePackErrors extends Table {
  IntColumn get id => integer().nullable()();
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  IntColumn get measureId => integer()();
  RealColumn get volume => real()();
  TextColumn get groupCode => text().nullable()();
  DateTimeColumn get localTs => dateTime()();

  @override
  Set<Column> get primaryKey => {orderId, subid};
}

class OrderLineStorageCodes extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get code => text()();
  TextColumn get groupCode => text().nullable()();
  IntColumn get amount => integer()();

  @override
  Set<Column> get primaryKey => {orderId, subid, code};
}

class OrderLineBarcodeListConverter extends TypeConverter<List<OrderLineBarcode>, String> {
  const OrderLineBarcodeListConverter();

  @override
  List<OrderLineBarcode> fromSql(String? fromDb) {
    return (json.decode(fromDb!) as List).map((e) => OrderLineBarcode.fromDart(e)).toList();
  }

  @override
  String toSql(List<OrderLineBarcode>? value) {
    return json.encode(value?.map((e) => e.toDart()).toList());
  }
}
