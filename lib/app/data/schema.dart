part of 'database.dart';

class Prefs extends Table {
  DateTimeColumn get lastLogin => dateTime().nullable()();
  DateTimeColumn get lastSyncTime => dateTime().nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get salesmanName => text()();
  TextColumn get salesmanNum => text()();
  TextColumn get email => text()();
  BoolColumn get closed => boolean()();
  TextColumn get version => text()();
  RealColumn get total => real()();
}

class ApiCredentials extends Table {
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  TextColumn get url => text()();
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
}

class CardPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buyerId => integer()();
  IntColumn get orderId => integer()();
  RealColumn get summ => real()();
  DateTimeColumn get ddate => dateTime()();
  TextColumn get transactionId => text().nullable()();
  BoolColumn get canceled => boolean()();
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
  BoolColumn get physical => boolean()();
}

class OrderLines extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get name => text()();
  TextColumn get gtin => text()();
  RealColumn get vol => real()();
  BoolColumn get needMarking => boolean()();

  @override
  Set<Column> get primaryKey => {orderId, subid};
}

class OrderLineCodes extends Table {
  IntColumn get orderId => integer()();
  IntColumn get subid => integer()();
  TextColumn get code => text()();

  @override
  Set<Column> get primaryKey => {orderId, subid, code};
}
