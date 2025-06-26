part of 'database.dart';

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

class Buyers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  DateTimeColumn get missedTs => dateTime().nullable()();
  DateTimeColumn get arrivalTs => dateTime().nullable()();
  DateTimeColumn get departureTs => dateTime().nullable()();
}

class CardPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer()();
  IntColumn get orderId => integer()();
  RealColumn get summ => real()();
  DateTimeColumn get ddate => dateTime()();
  TextColumn get transactionId => text().nullable()();
  BoolColumn get canceled => boolean()();
  BoolColumn get isLink => boolean()();
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
  TextColumn get barcodeRels => text().map(const OrderLineBarcodeListConverter())();

  @override
  Set<Column> get primaryKey => {orderId, subid};
}


class OrderLineCodes extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get code => text()();
  IntColumn get amount => integer()();
  BoolColumn get isDataMatrix => boolean()();
  DateTimeColumn get localTs => dateTime()();

  @override
  Set<Column> get primaryKey => {orderId, subid, code};
}

class OrderLineStorageCodes extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get code => text()();
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
