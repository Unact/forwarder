// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String salesmanName;
  final String salesmanNum;
  final String email;
  final bool closed;
  final String version;
  final double total;
  User(
      {required this.id,
      required this.username,
      required this.salesmanName,
      required this.salesmanNum,
      required this.email,
      required this.closed,
      required this.version,
      required this.total});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      salesmanName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}salesman_name'])!,
      salesmanNum: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}salesman_num'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      closed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}closed'])!,
      version: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}version'])!,
      total: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['salesman_name'] = Variable<String>(salesmanName);
    map['salesman_num'] = Variable<String>(salesmanNum);
    map['email'] = Variable<String>(email);
    map['closed'] = Variable<bool>(closed);
    map['version'] = Variable<String>(version);
    map['total'] = Variable<double>(total);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      salesmanName: Value(salesmanName),
      salesmanNum: Value(salesmanNum),
      email: Value(email),
      closed: Value(closed),
      version: Value(version),
      total: Value(total),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      salesmanName: serializer.fromJson<String>(json['salesmanName']),
      salesmanNum: serializer.fromJson<String>(json['salesmanNum']),
      email: serializer.fromJson<String>(json['email']),
      closed: serializer.fromJson<bool>(json['closed']),
      version: serializer.fromJson<String>(json['version']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'salesmanName': serializer.toJson<String>(salesmanName),
      'salesmanNum': serializer.toJson<String>(salesmanNum),
      'email': serializer.toJson<String>(email),
      'closed': serializer.toJson<bool>(closed),
      'version': serializer.toJson<String>(version),
      'total': serializer.toJson<double>(total),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? salesmanName,
          String? salesmanNum,
          String? email,
          bool? closed,
          String? version,
          double? total}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        salesmanName: salesmanName ?? this.salesmanName,
        salesmanNum: salesmanNum ?? this.salesmanNum,
        email: email ?? this.email,
        closed: closed ?? this.closed,
        version: version ?? this.version,
        total: total ?? this.total,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('salesmanName: $salesmanName, ')
          ..write('salesmanNum: $salesmanNum, ')
          ..write('email: $email, ')
          ..write('closed: $closed, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, username, salesmanName, salesmanNum, email, closed, version, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.salesmanName == this.salesmanName &&
          other.salesmanNum == this.salesmanNum &&
          other.email == this.email &&
          other.closed == this.closed &&
          other.version == this.version &&
          other.total == this.total);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> salesmanName;
  final Value<String> salesmanNum;
  final Value<String> email;
  final Value<bool> closed;
  final Value<String> version;
  final Value<double> total;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.salesmanName = const Value.absent(),
    this.salesmanNum = const Value.absent(),
    this.email = const Value.absent(),
    this.closed = const Value.absent(),
    this.version = const Value.absent(),
    this.total = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String salesmanName,
    required String salesmanNum,
    required String email,
    required bool closed,
    required String version,
    required double total,
  })  : username = Value(username),
        salesmanName = Value(salesmanName),
        salesmanNum = Value(salesmanNum),
        email = Value(email),
        closed = Value(closed),
        version = Value(version),
        total = Value(total);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? salesmanName,
    Expression<String>? salesmanNum,
    Expression<String>? email,
    Expression<bool>? closed,
    Expression<String>? version,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (salesmanName != null) 'salesman_name': salesmanName,
      if (salesmanNum != null) 'salesman_num': salesmanNum,
      if (email != null) 'email': email,
      if (closed != null) 'closed': closed,
      if (version != null) 'version': version,
      if (total != null) 'total': total,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? salesmanName,
      Value<String>? salesmanNum,
      Value<String>? email,
      Value<bool>? closed,
      Value<String>? version,
      Value<double>? total}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      salesmanName: salesmanName ?? this.salesmanName,
      salesmanNum: salesmanNum ?? this.salesmanNum,
      email: email ?? this.email,
      closed: closed ?? this.closed,
      version: version ?? this.version,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (salesmanName.present) {
      map['salesman_name'] = Variable<String>(salesmanName.value);
    }
    if (salesmanNum.present) {
      map['salesman_num'] = Variable<String>(salesmanNum.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (closed.present) {
      map['closed'] = Variable<bool>(closed.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('salesmanName: $salesmanName, ')
          ..write('salesmanNum: $salesmanNum, ')
          ..write('email: $email, ')
          ..write('closed: $closed, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _salesmanNameMeta =
      const VerificationMeta('salesmanName');
  @override
  late final GeneratedColumn<String?> salesmanName = GeneratedColumn<String?>(
      'salesman_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _salesmanNumMeta =
      const VerificationMeta('salesmanNum');
  @override
  late final GeneratedColumn<String?> salesmanNum = GeneratedColumn<String?>(
      'salesman_num', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _closedMeta = const VerificationMeta('closed');
  @override
  late final GeneratedColumn<bool?> closed = GeneratedColumn<bool?>(
      'closed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (closed IN (0, 1))');
  final VerificationMeta _versionMeta = const VerificationMeta('version');
  @override
  late final GeneratedColumn<String?> version = GeneratedColumn<String?>(
      'version', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double?> total = GeneratedColumn<double?>(
      'total', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, salesmanName, salesmanNum, email, closed, version, total];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('salesman_name')) {
      context.handle(
          _salesmanNameMeta,
          salesmanName.isAcceptableOrUnknown(
              data['salesman_name']!, _salesmanNameMeta));
    } else if (isInserting) {
      context.missing(_salesmanNameMeta);
    }
    if (data.containsKey('salesman_num')) {
      context.handle(
          _salesmanNumMeta,
          salesmanNum.isAcceptableOrUnknown(
              data['salesman_num']!, _salesmanNumMeta));
    } else if (isInserting) {
      context.missing(_salesmanNumMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('closed')) {
      context.handle(_closedMeta,
          closed.isAcceptableOrUnknown(data['closed']!, _closedMeta));
    } else if (isInserting) {
      context.missing(_closedMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Recept extends DataClass implements Insertable<Recept> {
  final int id;
  final DateTime ddate;
  final double summ;
  Recept({required this.id, required this.ddate, required this.summ});
  factory Recept.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Recept(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ddate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ddate'])!,
      summ: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summ'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ddate'] = Variable<DateTime>(ddate);
    map['summ'] = Variable<double>(summ);
    return map;
  }

  ReceptsCompanion toCompanion(bool nullToAbsent) {
    return ReceptsCompanion(
      id: Value(id),
      ddate: Value(ddate),
      summ: Value(summ),
    );
  }

  factory Recept.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recept(
      id: serializer.fromJson<int>(json['id']),
      ddate: serializer.fromJson<DateTime>(json['ddate']),
      summ: serializer.fromJson<double>(json['summ']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ddate': serializer.toJson<DateTime>(ddate),
      'summ': serializer.toJson<double>(summ),
    };
  }

  Recept copyWith({int? id, DateTime? ddate, double? summ}) => Recept(
        id: id ?? this.id,
        ddate: ddate ?? this.ddate,
        summ: summ ?? this.summ,
      );
  @override
  String toString() {
    return (StringBuffer('Recept(')
          ..write('id: $id, ')
          ..write('ddate: $ddate, ')
          ..write('summ: $summ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ddate, summ);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recept &&
          other.id == this.id &&
          other.ddate == this.ddate &&
          other.summ == this.summ);
}

class ReceptsCompanion extends UpdateCompanion<Recept> {
  final Value<int> id;
  final Value<DateTime> ddate;
  final Value<double> summ;
  const ReceptsCompanion({
    this.id = const Value.absent(),
    this.ddate = const Value.absent(),
    this.summ = const Value.absent(),
  });
  ReceptsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime ddate,
    required double summ,
  })  : ddate = Value(ddate),
        summ = Value(summ);
  static Insertable<Recept> custom({
    Expression<int>? id,
    Expression<DateTime>? ddate,
    Expression<double>? summ,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ddate != null) 'ddate': ddate,
      if (summ != null) 'summ': summ,
    });
  }

  ReceptsCompanion copyWith(
      {Value<int>? id, Value<DateTime>? ddate, Value<double>? summ}) {
    return ReceptsCompanion(
      id: id ?? this.id,
      ddate: ddate ?? this.ddate,
      summ: summ ?? this.summ,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ddate.present) {
      map['ddate'] = Variable<DateTime>(ddate.value);
    }
    if (summ.present) {
      map['summ'] = Variable<double>(summ.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceptsCompanion(')
          ..write('id: $id, ')
          ..write('ddate: $ddate, ')
          ..write('summ: $summ')
          ..write(')'))
        .toString();
  }
}

class $ReceptsTable extends Recepts with TableInfo<$ReceptsTable, Recept> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceptsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime?> ddate = GeneratedColumn<DateTime?>(
      'ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double?> summ = GeneratedColumn<double?>(
      'summ', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ddate, summ];
  @override
  String get aliasedName => _alias ?? 'recepts';
  @override
  String get actualTableName => 'recepts';
  @override
  VerificationContext validateIntegrity(Insertable<Recept> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ddate')) {
      context.handle(
          _ddateMeta, ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta));
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
          _summMeta, summ.isAcceptableOrUnknown(data['summ']!, _summMeta));
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recept map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Recept.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ReceptsTable createAlias(String alias) {
    return $ReceptsTable(attachedDatabase, alias);
  }
}

class Income extends DataClass implements Insertable<Income> {
  final int id;
  final DateTime ddate;
  final double summ;
  Income({required this.id, required this.ddate, required this.summ});
  factory Income.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Income(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ddate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ddate'])!,
      summ: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summ'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ddate'] = Variable<DateTime>(ddate);
    map['summ'] = Variable<double>(summ);
    return map;
  }

  IncomesCompanion toCompanion(bool nullToAbsent) {
    return IncomesCompanion(
      id: Value(id),
      ddate: Value(ddate),
      summ: Value(summ),
    );
  }

  factory Income.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Income(
      id: serializer.fromJson<int>(json['id']),
      ddate: serializer.fromJson<DateTime>(json['ddate']),
      summ: serializer.fromJson<double>(json['summ']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ddate': serializer.toJson<DateTime>(ddate),
      'summ': serializer.toJson<double>(summ),
    };
  }

  Income copyWith({int? id, DateTime? ddate, double? summ}) => Income(
        id: id ?? this.id,
        ddate: ddate ?? this.ddate,
        summ: summ ?? this.summ,
      );
  @override
  String toString() {
    return (StringBuffer('Income(')
          ..write('id: $id, ')
          ..write('ddate: $ddate, ')
          ..write('summ: $summ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ddate, summ);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Income &&
          other.id == this.id &&
          other.ddate == this.ddate &&
          other.summ == this.summ);
}

class IncomesCompanion extends UpdateCompanion<Income> {
  final Value<int> id;
  final Value<DateTime> ddate;
  final Value<double> summ;
  const IncomesCompanion({
    this.id = const Value.absent(),
    this.ddate = const Value.absent(),
    this.summ = const Value.absent(),
  });
  IncomesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime ddate,
    required double summ,
  })  : ddate = Value(ddate),
        summ = Value(summ);
  static Insertable<Income> custom({
    Expression<int>? id,
    Expression<DateTime>? ddate,
    Expression<double>? summ,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ddate != null) 'ddate': ddate,
      if (summ != null) 'summ': summ,
    });
  }

  IncomesCompanion copyWith(
      {Value<int>? id, Value<DateTime>? ddate, Value<double>? summ}) {
    return IncomesCompanion(
      id: id ?? this.id,
      ddate: ddate ?? this.ddate,
      summ: summ ?? this.summ,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ddate.present) {
      map['ddate'] = Variable<DateTime>(ddate.value);
    }
    if (summ.present) {
      map['summ'] = Variable<double>(summ.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCompanion(')
          ..write('id: $id, ')
          ..write('ddate: $ddate, ')
          ..write('summ: $summ')
          ..write(')'))
        .toString();
  }
}

class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime?> ddate = GeneratedColumn<DateTime?>(
      'ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double?> summ = GeneratedColumn<double?>(
      'summ', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ddate, summ];
  @override
  String get aliasedName => _alias ?? 'incomes';
  @override
  String get actualTableName => 'incomes';
  @override
  VerificationContext validateIntegrity(Insertable<Income> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ddate')) {
      context.handle(
          _ddateMeta, ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta));
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
          _summMeta, summ.isAcceptableOrUnknown(data['summ']!, _summMeta));
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Income.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }
}

class Buyer extends DataClass implements Insertable<Buyer> {
  final int id;
  final String name;
  final String address;
  Buyer({required this.id, required this.name, required this.address});
  factory Buyer.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Buyer(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    return map;
  }

  BuyersCompanion toCompanion(bool nullToAbsent) {
    return BuyersCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
    );
  }

  factory Buyer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Buyer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
    };
  }

  Buyer copyWith({int? id, String? name, String? address}) => Buyer(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
      );
  @override
  String toString() {
    return (StringBuffer('Buyer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Buyer &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address);
}

class BuyersCompanion extends UpdateCompanion<Buyer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  const BuyersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
  });
  BuyersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String address,
  })  : name = Value(name),
        address = Value(address);
  static Insertable<Buyer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
    });
  }

  BuyersCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? address}) {
    return BuyersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $BuyersTable extends Buyers with TableInfo<$BuyersTable, Buyer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, address];
  @override
  String get aliasedName => _alias ?? 'buyers';
  @override
  String get actualTableName => 'buyers';
  @override
  VerificationContext validateIntegrity(Insertable<Buyer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Buyer map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Buyer.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BuyersTable createAlias(String alias) {
    return $BuyersTable(attachedDatabase, alias);
  }
}

class CardPayment extends DataClass implements Insertable<CardPayment> {
  final int id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final String? transactionId;
  final bool canceled;
  final bool isLink;
  CardPayment(
      {required this.id,
      required this.buyerId,
      required this.orderId,
      required this.summ,
      required this.ddate,
      this.transactionId,
      required this.canceled,
      required this.isLink});
  factory CardPayment.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CardPayment(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      buyerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}buyer_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      summ: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summ'])!,
      ddate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ddate'])!,
      transactionId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id']),
      canceled: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}canceled'])!,
      isLink: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_link'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['order_id'] = Variable<int>(orderId);
    map['summ'] = Variable<double>(summ);
    map['ddate'] = Variable<DateTime>(ddate);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String?>(transactionId);
    }
    map['canceled'] = Variable<bool>(canceled);
    map['is_link'] = Variable<bool>(isLink);
    return map;
  }

  CardPaymentsCompanion toCompanion(bool nullToAbsent) {
    return CardPaymentsCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      orderId: Value(orderId),
      summ: Value(summ),
      ddate: Value(ddate),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      canceled: Value(canceled),
      isLink: Value(isLink),
    );
  }

  factory CardPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardPayment(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      summ: serializer.fromJson<double>(json['summ']),
      ddate: serializer.fromJson<DateTime>(json['ddate']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      canceled: serializer.fromJson<bool>(json['canceled']),
      isLink: serializer.fromJson<bool>(json['isLink']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'orderId': serializer.toJson<int>(orderId),
      'summ': serializer.toJson<double>(summ),
      'ddate': serializer.toJson<DateTime>(ddate),
      'transactionId': serializer.toJson<String?>(transactionId),
      'canceled': serializer.toJson<bool>(canceled),
      'isLink': serializer.toJson<bool>(isLink),
    };
  }

  CardPayment copyWith(
          {int? id,
          int? buyerId,
          int? orderId,
          double? summ,
          DateTime? ddate,
          String? transactionId,
          bool? canceled,
          bool? isLink}) =>
      CardPayment(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        orderId: orderId ?? this.orderId,
        summ: summ ?? this.summ,
        ddate: ddate ?? this.ddate,
        transactionId: transactionId ?? this.transactionId,
        canceled: canceled ?? this.canceled,
        isLink: isLink ?? this.isLink,
      );
  @override
  String toString() {
    return (StringBuffer('CardPayment(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('summ: $summ, ')
          ..write('ddate: $ddate, ')
          ..write('transactionId: $transactionId, ')
          ..write('canceled: $canceled, ')
          ..write('isLink: $isLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, buyerId, orderId, summ, ddate, transactionId, canceled, isLink);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardPayment &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.orderId == this.orderId &&
          other.summ == this.summ &&
          other.ddate == this.ddate &&
          other.transactionId == this.transactionId &&
          other.canceled == this.canceled &&
          other.isLink == this.isLink);
}

class CardPaymentsCompanion extends UpdateCompanion<CardPayment> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> orderId;
  final Value<double> summ;
  final Value<DateTime> ddate;
  final Value<String?> transactionId;
  final Value<bool> canceled;
  final Value<bool> isLink;
  const CardPaymentsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.summ = const Value.absent(),
    this.ddate = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.canceled = const Value.absent(),
    this.isLink = const Value.absent(),
  });
  CardPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int orderId,
    required double summ,
    required DateTime ddate,
    this.transactionId = const Value.absent(),
    required bool canceled,
    required bool isLink,
  })  : buyerId = Value(buyerId),
        orderId = Value(orderId),
        summ = Value(summ),
        ddate = Value(ddate),
        canceled = Value(canceled),
        isLink = Value(isLink);
  static Insertable<CardPayment> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? orderId,
    Expression<double>? summ,
    Expression<DateTime>? ddate,
    Expression<String?>? transactionId,
    Expression<bool>? canceled,
    Expression<bool>? isLink,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (orderId != null) 'order_id': orderId,
      if (summ != null) 'summ': summ,
      if (ddate != null) 'ddate': ddate,
      if (transactionId != null) 'transaction_id': transactionId,
      if (canceled != null) 'canceled': canceled,
      if (isLink != null) 'is_link': isLink,
    });
  }

  CardPaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? buyerId,
      Value<int>? orderId,
      Value<double>? summ,
      Value<DateTime>? ddate,
      Value<String?>? transactionId,
      Value<bool>? canceled,
      Value<bool>? isLink}) {
    return CardPaymentsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      orderId: orderId ?? this.orderId,
      summ: summ ?? this.summ,
      ddate: ddate ?? this.ddate,
      transactionId: transactionId ?? this.transactionId,
      canceled: canceled ?? this.canceled,
      isLink: isLink ?? this.isLink,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (summ.present) {
      map['summ'] = Variable<double>(summ.value);
    }
    if (ddate.present) {
      map['ddate'] = Variable<DateTime>(ddate.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String?>(transactionId.value);
    }
    if (canceled.present) {
      map['canceled'] = Variable<bool>(canceled.value);
    }
    if (isLink.present) {
      map['is_link'] = Variable<bool>(isLink.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('summ: $summ, ')
          ..write('ddate: $ddate, ')
          ..write('transactionId: $transactionId, ')
          ..write('canceled: $canceled, ')
          ..write('isLink: $isLink')
          ..write(')'))
        .toString();
  }
}

class $CardPaymentsTable extends CardPayments
    with TableInfo<$CardPaymentsTable, CardPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardPaymentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _buyerIdMeta = const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<int?> buyerId = GeneratedColumn<int?>(
      'buyer_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double?> summ = GeneratedColumn<double?>(
      'summ', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime?> ddate = GeneratedColumn<DateTime?>(
      'ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String?> transactionId = GeneratedColumn<String?>(
      'transaction_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _canceledMeta = const VerificationMeta('canceled');
  @override
  late final GeneratedColumn<bool?> canceled = GeneratedColumn<bool?>(
      'canceled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (canceled IN (0, 1))');
  final VerificationMeta _isLinkMeta = const VerificationMeta('isLink');
  @override
  late final GeneratedColumn<bool?> isLink = GeneratedColumn<bool?>(
      'is_link', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_link IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, buyerId, orderId, summ, ddate, transactionId, canceled, isLink];
  @override
  String get aliasedName => _alias ?? 'card_payments';
  @override
  String get actualTableName => 'card_payments';
  @override
  VerificationContext validateIntegrity(Insertable<CardPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
          _summMeta, summ.isAcceptableOrUnknown(data['summ']!, _summMeta));
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    if (data.containsKey('ddate')) {
      context.handle(
          _ddateMeta, ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta));
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('canceled')) {
      context.handle(_canceledMeta,
          canceled.isAcceptableOrUnknown(data['canceled']!, _canceledMeta));
    } else if (isInserting) {
      context.missing(_canceledMeta);
    }
    if (data.containsKey('is_link')) {
      context.handle(_isLinkMeta,
          isLink.isAcceptableOrUnknown(data['is_link']!, _isLinkMeta));
    } else if (isInserting) {
      context.missing(_isLinkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CardPayment.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CardPaymentsTable createAlias(String alias) {
    return $CardPaymentsTable(attachedDatabase, alias);
  }
}

class CashPayment extends DataClass implements Insertable<CashPayment> {
  final int id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final bool kkmprinted;
  CashPayment(
      {required this.id,
      required this.buyerId,
      required this.orderId,
      required this.summ,
      required this.ddate,
      required this.kkmprinted});
  factory CashPayment.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CashPayment(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      buyerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}buyer_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      summ: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summ'])!,
      ddate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ddate'])!,
      kkmprinted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}kkmprinted'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['order_id'] = Variable<int>(orderId);
    map['summ'] = Variable<double>(summ);
    map['ddate'] = Variable<DateTime>(ddate);
    map['kkmprinted'] = Variable<bool>(kkmprinted);
    return map;
  }

  CashPaymentsCompanion toCompanion(bool nullToAbsent) {
    return CashPaymentsCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      orderId: Value(orderId),
      summ: Value(summ),
      ddate: Value(ddate),
      kkmprinted: Value(kkmprinted),
    );
  }

  factory CashPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashPayment(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      summ: serializer.fromJson<double>(json['summ']),
      ddate: serializer.fromJson<DateTime>(json['ddate']),
      kkmprinted: serializer.fromJson<bool>(json['kkmprinted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'orderId': serializer.toJson<int>(orderId),
      'summ': serializer.toJson<double>(summ),
      'ddate': serializer.toJson<DateTime>(ddate),
      'kkmprinted': serializer.toJson<bool>(kkmprinted),
    };
  }

  CashPayment copyWith(
          {int? id,
          int? buyerId,
          int? orderId,
          double? summ,
          DateTime? ddate,
          bool? kkmprinted}) =>
      CashPayment(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        orderId: orderId ?? this.orderId,
        summ: summ ?? this.summ,
        ddate: ddate ?? this.ddate,
        kkmprinted: kkmprinted ?? this.kkmprinted,
      );
  @override
  String toString() {
    return (StringBuffer('CashPayment(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('summ: $summ, ')
          ..write('ddate: $ddate, ')
          ..write('kkmprinted: $kkmprinted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, buyerId, orderId, summ, ddate, kkmprinted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashPayment &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.orderId == this.orderId &&
          other.summ == this.summ &&
          other.ddate == this.ddate &&
          other.kkmprinted == this.kkmprinted);
}

class CashPaymentsCompanion extends UpdateCompanion<CashPayment> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> orderId;
  final Value<double> summ;
  final Value<DateTime> ddate;
  final Value<bool> kkmprinted;
  const CashPaymentsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.summ = const Value.absent(),
    this.ddate = const Value.absent(),
    this.kkmprinted = const Value.absent(),
  });
  CashPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int orderId,
    required double summ,
    required DateTime ddate,
    required bool kkmprinted,
  })  : buyerId = Value(buyerId),
        orderId = Value(orderId),
        summ = Value(summ),
        ddate = Value(ddate),
        kkmprinted = Value(kkmprinted);
  static Insertable<CashPayment> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? orderId,
    Expression<double>? summ,
    Expression<DateTime>? ddate,
    Expression<bool>? kkmprinted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (orderId != null) 'order_id': orderId,
      if (summ != null) 'summ': summ,
      if (ddate != null) 'ddate': ddate,
      if (kkmprinted != null) 'kkmprinted': kkmprinted,
    });
  }

  CashPaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? buyerId,
      Value<int>? orderId,
      Value<double>? summ,
      Value<DateTime>? ddate,
      Value<bool>? kkmprinted}) {
    return CashPaymentsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      orderId: orderId ?? this.orderId,
      summ: summ ?? this.summ,
      ddate: ddate ?? this.ddate,
      kkmprinted: kkmprinted ?? this.kkmprinted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (summ.present) {
      map['summ'] = Variable<double>(summ.value);
    }
    if (ddate.present) {
      map['ddate'] = Variable<DateTime>(ddate.value);
    }
    if (kkmprinted.present) {
      map['kkmprinted'] = Variable<bool>(kkmprinted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('summ: $summ, ')
          ..write('ddate: $ddate, ')
          ..write('kkmprinted: $kkmprinted')
          ..write(')'))
        .toString();
  }
}

class $CashPaymentsTable extends CashPayments
    with TableInfo<$CashPaymentsTable, CashPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashPaymentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _buyerIdMeta = const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<int?> buyerId = GeneratedColumn<int?>(
      'buyer_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double?> summ = GeneratedColumn<double?>(
      'summ', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime?> ddate = GeneratedColumn<DateTime?>(
      'ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _kkmprintedMeta = const VerificationMeta('kkmprinted');
  @override
  late final GeneratedColumn<bool?> kkmprinted = GeneratedColumn<bool?>(
      'kkmprinted', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (kkmprinted IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, buyerId, orderId, summ, ddate, kkmprinted];
  @override
  String get aliasedName => _alias ?? 'cash_payments';
  @override
  String get actualTableName => 'cash_payments';
  @override
  VerificationContext validateIntegrity(Insertable<CashPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
          _summMeta, summ.isAcceptableOrUnknown(data['summ']!, _summMeta));
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    if (data.containsKey('ddate')) {
      context.handle(
          _ddateMeta, ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta));
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('kkmprinted')) {
      context.handle(
          _kkmprintedMeta,
          kkmprinted.isAcceptableOrUnknown(
              data['kkmprinted']!, _kkmprintedMeta));
    } else if (isInserting) {
      context.missing(_kkmprintedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CashPayment.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CashPaymentsTable createAlias(String alias) {
    return $CashPaymentsTable(attachedDatabase, alias);
  }
}

class Debt extends DataClass implements Insertable<Debt> {
  final int id;
  final int buyerId;
  final int orderId;
  final String ndoc;
  final String orderNdoc;
  final DateTime ddate;
  final DateTime orderDdate;
  final bool isCheck;
  final double debtSum;
  final double orderSum;
  final double? paidSum;
  final double? paymentSum;
  final bool physical;
  Debt(
      {required this.id,
      required this.buyerId,
      required this.orderId,
      required this.ndoc,
      required this.orderNdoc,
      required this.ddate,
      required this.orderDdate,
      required this.isCheck,
      required this.debtSum,
      required this.orderSum,
      this.paidSum,
      this.paymentSum,
      required this.physical});
  factory Debt.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Debt(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      buyerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}buyer_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      ndoc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ndoc'])!,
      orderNdoc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_ndoc'])!,
      ddate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ddate'])!,
      orderDdate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_ddate'])!,
      isCheck: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_check'])!,
      debtSum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}debt_sum'])!,
      orderSum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_sum'])!,
      paidSum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}paid_sum']),
      paymentSum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_sum']),
      physical: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}physical'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['order_id'] = Variable<int>(orderId);
    map['ndoc'] = Variable<String>(ndoc);
    map['order_ndoc'] = Variable<String>(orderNdoc);
    map['ddate'] = Variable<DateTime>(ddate);
    map['order_ddate'] = Variable<DateTime>(orderDdate);
    map['is_check'] = Variable<bool>(isCheck);
    map['debt_sum'] = Variable<double>(debtSum);
    map['order_sum'] = Variable<double>(orderSum);
    if (!nullToAbsent || paidSum != null) {
      map['paid_sum'] = Variable<double?>(paidSum);
    }
    if (!nullToAbsent || paymentSum != null) {
      map['payment_sum'] = Variable<double?>(paymentSum);
    }
    map['physical'] = Variable<bool>(physical);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      orderId: Value(orderId),
      ndoc: Value(ndoc),
      orderNdoc: Value(orderNdoc),
      ddate: Value(ddate),
      orderDdate: Value(orderDdate),
      isCheck: Value(isCheck),
      debtSum: Value(debtSum),
      orderSum: Value(orderSum),
      paidSum: paidSum == null && nullToAbsent
          ? const Value.absent()
          : Value(paidSum),
      paymentSum: paymentSum == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentSum),
      physical: Value(physical),
    );
  }

  factory Debt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      ndoc: serializer.fromJson<String>(json['ndoc']),
      orderNdoc: serializer.fromJson<String>(json['orderNdoc']),
      ddate: serializer.fromJson<DateTime>(json['ddate']),
      orderDdate: serializer.fromJson<DateTime>(json['orderDdate']),
      isCheck: serializer.fromJson<bool>(json['isCheck']),
      debtSum: serializer.fromJson<double>(json['debtSum']),
      orderSum: serializer.fromJson<double>(json['orderSum']),
      paidSum: serializer.fromJson<double?>(json['paidSum']),
      paymentSum: serializer.fromJson<double?>(json['paymentSum']),
      physical: serializer.fromJson<bool>(json['physical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'orderId': serializer.toJson<int>(orderId),
      'ndoc': serializer.toJson<String>(ndoc),
      'orderNdoc': serializer.toJson<String>(orderNdoc),
      'ddate': serializer.toJson<DateTime>(ddate),
      'orderDdate': serializer.toJson<DateTime>(orderDdate),
      'isCheck': serializer.toJson<bool>(isCheck),
      'debtSum': serializer.toJson<double>(debtSum),
      'orderSum': serializer.toJson<double>(orderSum),
      'paidSum': serializer.toJson<double?>(paidSum),
      'paymentSum': serializer.toJson<double?>(paymentSum),
      'physical': serializer.toJson<bool>(physical),
    };
  }

  Debt copyWith(
          {int? id,
          int? buyerId,
          int? orderId,
          String? ndoc,
          String? orderNdoc,
          DateTime? ddate,
          DateTime? orderDdate,
          bool? isCheck,
          double? debtSum,
          double? orderSum,
          double? paidSum,
          double? paymentSum,
          bool? physical}) =>
      Debt(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        orderId: orderId ?? this.orderId,
        ndoc: ndoc ?? this.ndoc,
        orderNdoc: orderNdoc ?? this.orderNdoc,
        ddate: ddate ?? this.ddate,
        orderDdate: orderDdate ?? this.orderDdate,
        isCheck: isCheck ?? this.isCheck,
        debtSum: debtSum ?? this.debtSum,
        orderSum: orderSum ?? this.orderSum,
        paidSum: paidSum ?? this.paidSum,
        paymentSum: paymentSum ?? this.paymentSum,
        physical: physical ?? this.physical,
      );
  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('ndoc: $ndoc, ')
          ..write('orderNdoc: $orderNdoc, ')
          ..write('ddate: $ddate, ')
          ..write('orderDdate: $orderDdate, ')
          ..write('isCheck: $isCheck, ')
          ..write('debtSum: $debtSum, ')
          ..write('orderSum: $orderSum, ')
          ..write('paidSum: $paidSum, ')
          ..write('paymentSum: $paymentSum, ')
          ..write('physical: $physical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, buyerId, orderId, ndoc, orderNdoc, ddate,
      orderDdate, isCheck, debtSum, orderSum, paidSum, paymentSum, physical);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.orderId == this.orderId &&
          other.ndoc == this.ndoc &&
          other.orderNdoc == this.orderNdoc &&
          other.ddate == this.ddate &&
          other.orderDdate == this.orderDdate &&
          other.isCheck == this.isCheck &&
          other.debtSum == this.debtSum &&
          other.orderSum == this.orderSum &&
          other.paidSum == this.paidSum &&
          other.paymentSum == this.paymentSum &&
          other.physical == this.physical);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> orderId;
  final Value<String> ndoc;
  final Value<String> orderNdoc;
  final Value<DateTime> ddate;
  final Value<DateTime> orderDdate;
  final Value<bool> isCheck;
  final Value<double> debtSum;
  final Value<double> orderSum;
  final Value<double?> paidSum;
  final Value<double?> paymentSum;
  final Value<bool> physical;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.ndoc = const Value.absent(),
    this.orderNdoc = const Value.absent(),
    this.ddate = const Value.absent(),
    this.orderDdate = const Value.absent(),
    this.isCheck = const Value.absent(),
    this.debtSum = const Value.absent(),
    this.orderSum = const Value.absent(),
    this.paidSum = const Value.absent(),
    this.paymentSum = const Value.absent(),
    this.physical = const Value.absent(),
  });
  DebtsCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int orderId,
    required String ndoc,
    required String orderNdoc,
    required DateTime ddate,
    required DateTime orderDdate,
    required bool isCheck,
    required double debtSum,
    required double orderSum,
    this.paidSum = const Value.absent(),
    this.paymentSum = const Value.absent(),
    required bool physical,
  })  : buyerId = Value(buyerId),
        orderId = Value(orderId),
        ndoc = Value(ndoc),
        orderNdoc = Value(orderNdoc),
        ddate = Value(ddate),
        orderDdate = Value(orderDdate),
        isCheck = Value(isCheck),
        debtSum = Value(debtSum),
        orderSum = Value(orderSum),
        physical = Value(physical);
  static Insertable<Debt> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? orderId,
    Expression<String>? ndoc,
    Expression<String>? orderNdoc,
    Expression<DateTime>? ddate,
    Expression<DateTime>? orderDdate,
    Expression<bool>? isCheck,
    Expression<double>? debtSum,
    Expression<double>? orderSum,
    Expression<double?>? paidSum,
    Expression<double?>? paymentSum,
    Expression<bool>? physical,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (orderId != null) 'order_id': orderId,
      if (ndoc != null) 'ndoc': ndoc,
      if (orderNdoc != null) 'order_ndoc': orderNdoc,
      if (ddate != null) 'ddate': ddate,
      if (orderDdate != null) 'order_ddate': orderDdate,
      if (isCheck != null) 'is_check': isCheck,
      if (debtSum != null) 'debt_sum': debtSum,
      if (orderSum != null) 'order_sum': orderSum,
      if (paidSum != null) 'paid_sum': paidSum,
      if (paymentSum != null) 'payment_sum': paymentSum,
      if (physical != null) 'physical': physical,
    });
  }

  DebtsCompanion copyWith(
      {Value<int>? id,
      Value<int>? buyerId,
      Value<int>? orderId,
      Value<String>? ndoc,
      Value<String>? orderNdoc,
      Value<DateTime>? ddate,
      Value<DateTime>? orderDdate,
      Value<bool>? isCheck,
      Value<double>? debtSum,
      Value<double>? orderSum,
      Value<double?>? paidSum,
      Value<double?>? paymentSum,
      Value<bool>? physical}) {
    return DebtsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      orderId: orderId ?? this.orderId,
      ndoc: ndoc ?? this.ndoc,
      orderNdoc: orderNdoc ?? this.orderNdoc,
      ddate: ddate ?? this.ddate,
      orderDdate: orderDdate ?? this.orderDdate,
      isCheck: isCheck ?? this.isCheck,
      debtSum: debtSum ?? this.debtSum,
      orderSum: orderSum ?? this.orderSum,
      paidSum: paidSum ?? this.paidSum,
      paymentSum: paymentSum ?? this.paymentSum,
      physical: physical ?? this.physical,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (ndoc.present) {
      map['ndoc'] = Variable<String>(ndoc.value);
    }
    if (orderNdoc.present) {
      map['order_ndoc'] = Variable<String>(orderNdoc.value);
    }
    if (ddate.present) {
      map['ddate'] = Variable<DateTime>(ddate.value);
    }
    if (orderDdate.present) {
      map['order_ddate'] = Variable<DateTime>(orderDdate.value);
    }
    if (isCheck.present) {
      map['is_check'] = Variable<bool>(isCheck.value);
    }
    if (debtSum.present) {
      map['debt_sum'] = Variable<double>(debtSum.value);
    }
    if (orderSum.present) {
      map['order_sum'] = Variable<double>(orderSum.value);
    }
    if (paidSum.present) {
      map['paid_sum'] = Variable<double?>(paidSum.value);
    }
    if (paymentSum.present) {
      map['payment_sum'] = Variable<double?>(paymentSum.value);
    }
    if (physical.present) {
      map['physical'] = Variable<bool>(physical.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('orderId: $orderId, ')
          ..write('ndoc: $ndoc, ')
          ..write('orderNdoc: $orderNdoc, ')
          ..write('ddate: $ddate, ')
          ..write('orderDdate: $orderDdate, ')
          ..write('isCheck: $isCheck, ')
          ..write('debtSum: $debtSum, ')
          ..write('orderSum: $orderSum, ')
          ..write('paidSum: $paidSum, ')
          ..write('paymentSum: $paymentSum, ')
          ..write('physical: $physical')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _buyerIdMeta = const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<int?> buyerId = GeneratedColumn<int?>(
      'buyer_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _ndocMeta = const VerificationMeta('ndoc');
  @override
  late final GeneratedColumn<String?> ndoc = GeneratedColumn<String?>(
      'ndoc', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _orderNdocMeta = const VerificationMeta('orderNdoc');
  @override
  late final GeneratedColumn<String?> orderNdoc = GeneratedColumn<String?>(
      'order_ndoc', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime?> ddate = GeneratedColumn<DateTime?>(
      'ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _orderDdateMeta = const VerificationMeta('orderDdate');
  @override
  late final GeneratedColumn<DateTime?> orderDdate = GeneratedColumn<DateTime?>(
      'order_ddate', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isCheckMeta = const VerificationMeta('isCheck');
  @override
  late final GeneratedColumn<bool?> isCheck = GeneratedColumn<bool?>(
      'is_check', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_check IN (0, 1))');
  final VerificationMeta _debtSumMeta = const VerificationMeta('debtSum');
  @override
  late final GeneratedColumn<double?> debtSum = GeneratedColumn<double?>(
      'debt_sum', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _orderSumMeta = const VerificationMeta('orderSum');
  @override
  late final GeneratedColumn<double?> orderSum = GeneratedColumn<double?>(
      'order_sum', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _paidSumMeta = const VerificationMeta('paidSum');
  @override
  late final GeneratedColumn<double?> paidSum = GeneratedColumn<double?>(
      'paid_sum', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _paymentSumMeta = const VerificationMeta('paymentSum');
  @override
  late final GeneratedColumn<double?> paymentSum = GeneratedColumn<double?>(
      'payment_sum', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _physicalMeta = const VerificationMeta('physical');
  @override
  late final GeneratedColumn<bool?> physical = GeneratedColumn<bool?>(
      'physical', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (physical IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        buyerId,
        orderId,
        ndoc,
        orderNdoc,
        ddate,
        orderDdate,
        isCheck,
        debtSum,
        orderSum,
        paidSum,
        paymentSum,
        physical
      ];
  @override
  String get aliasedName => _alias ?? 'debts';
  @override
  String get actualTableName => 'debts';
  @override
  VerificationContext validateIntegrity(Insertable<Debt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('ndoc')) {
      context.handle(
          _ndocMeta, ndoc.isAcceptableOrUnknown(data['ndoc']!, _ndocMeta));
    } else if (isInserting) {
      context.missing(_ndocMeta);
    }
    if (data.containsKey('order_ndoc')) {
      context.handle(_orderNdocMeta,
          orderNdoc.isAcceptableOrUnknown(data['order_ndoc']!, _orderNdocMeta));
    } else if (isInserting) {
      context.missing(_orderNdocMeta);
    }
    if (data.containsKey('ddate')) {
      context.handle(
          _ddateMeta, ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta));
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('order_ddate')) {
      context.handle(
          _orderDdateMeta,
          orderDdate.isAcceptableOrUnknown(
              data['order_ddate']!, _orderDdateMeta));
    } else if (isInserting) {
      context.missing(_orderDdateMeta);
    }
    if (data.containsKey('is_check')) {
      context.handle(_isCheckMeta,
          isCheck.isAcceptableOrUnknown(data['is_check']!, _isCheckMeta));
    } else if (isInserting) {
      context.missing(_isCheckMeta);
    }
    if (data.containsKey('debt_sum')) {
      context.handle(_debtSumMeta,
          debtSum.isAcceptableOrUnknown(data['debt_sum']!, _debtSumMeta));
    } else if (isInserting) {
      context.missing(_debtSumMeta);
    }
    if (data.containsKey('order_sum')) {
      context.handle(_orderSumMeta,
          orderSum.isAcceptableOrUnknown(data['order_sum']!, _orderSumMeta));
    } else if (isInserting) {
      context.missing(_orderSumMeta);
    }
    if (data.containsKey('paid_sum')) {
      context.handle(_paidSumMeta,
          paidSum.isAcceptableOrUnknown(data['paid_sum']!, _paidSumMeta));
    }
    if (data.containsKey('payment_sum')) {
      context.handle(
          _paymentSumMeta,
          paymentSum.isAcceptableOrUnknown(
              data['payment_sum']!, _paymentSumMeta));
    }
    if (data.containsKey('physical')) {
      context.handle(_physicalMeta,
          physical.isAcceptableOrUnknown(data['physical']!, _physicalMeta));
    } else if (isInserting) {
      context.missing(_physicalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Debt.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int buyerId;
  final int ord;
  final String ndoc;
  final String info;
  final bool isInc;
  final int goodsCnt;
  final double mc;
  final bool? delivered;
  final bool physical;
  Order(
      {required this.id,
      required this.buyerId,
      required this.ord,
      required this.ndoc,
      required this.info,
      required this.isInc,
      required this.goodsCnt,
      required this.mc,
      this.delivered,
      required this.physical});
  factory Order.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Order(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      buyerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}buyer_id'])!,
      ord: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ord'])!,
      ndoc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ndoc'])!,
      info: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}info'])!,
      isInc: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_inc'])!,
      goodsCnt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}goods_cnt'])!,
      mc: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mc'])!,
      delivered: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivered']),
      physical: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}physical'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['ord'] = Variable<int>(ord);
    map['ndoc'] = Variable<String>(ndoc);
    map['info'] = Variable<String>(info);
    map['is_inc'] = Variable<bool>(isInc);
    map['goods_cnt'] = Variable<int>(goodsCnt);
    map['mc'] = Variable<double>(mc);
    if (!nullToAbsent || delivered != null) {
      map['delivered'] = Variable<bool?>(delivered);
    }
    map['physical'] = Variable<bool>(physical);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      ord: Value(ord),
      ndoc: Value(ndoc),
      info: Value(info),
      isInc: Value(isInc),
      goodsCnt: Value(goodsCnt),
      mc: Value(mc),
      delivered: delivered == null && nullToAbsent
          ? const Value.absent()
          : Value(delivered),
      physical: Value(physical),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      ord: serializer.fromJson<int>(json['ord']),
      ndoc: serializer.fromJson<String>(json['ndoc']),
      info: serializer.fromJson<String>(json['info']),
      isInc: serializer.fromJson<bool>(json['isInc']),
      goodsCnt: serializer.fromJson<int>(json['goodsCnt']),
      mc: serializer.fromJson<double>(json['mc']),
      delivered: serializer.fromJson<bool?>(json['delivered']),
      physical: serializer.fromJson<bool>(json['physical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'ord': serializer.toJson<int>(ord),
      'ndoc': serializer.toJson<String>(ndoc),
      'info': serializer.toJson<String>(info),
      'isInc': serializer.toJson<bool>(isInc),
      'goodsCnt': serializer.toJson<int>(goodsCnt),
      'mc': serializer.toJson<double>(mc),
      'delivered': serializer.toJson<bool?>(delivered),
      'physical': serializer.toJson<bool>(physical),
    };
  }

  Order copyWith(
          {int? id,
          int? buyerId,
          int? ord,
          String? ndoc,
          String? info,
          bool? isInc,
          int? goodsCnt,
          double? mc,
          bool? delivered,
          bool? physical}) =>
      Order(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        ord: ord ?? this.ord,
        ndoc: ndoc ?? this.ndoc,
        info: info ?? this.info,
        isInc: isInc ?? this.isInc,
        goodsCnt: goodsCnt ?? this.goodsCnt,
        mc: mc ?? this.mc,
        delivered: delivered ?? this.delivered,
        physical: physical ?? this.physical,
      );
  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('ord: $ord, ')
          ..write('ndoc: $ndoc, ')
          ..write('info: $info, ')
          ..write('isInc: $isInc, ')
          ..write('goodsCnt: $goodsCnt, ')
          ..write('mc: $mc, ')
          ..write('delivered: $delivered, ')
          ..write('physical: $physical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, buyerId, ord, ndoc, info, isInc, goodsCnt, mc, delivered, physical);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.ord == this.ord &&
          other.ndoc == this.ndoc &&
          other.info == this.info &&
          other.isInc == this.isInc &&
          other.goodsCnt == this.goodsCnt &&
          other.mc == this.mc &&
          other.delivered == this.delivered &&
          other.physical == this.physical);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> ord;
  final Value<String> ndoc;
  final Value<String> info;
  final Value<bool> isInc;
  final Value<int> goodsCnt;
  final Value<double> mc;
  final Value<bool?> delivered;
  final Value<bool> physical;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.ord = const Value.absent(),
    this.ndoc = const Value.absent(),
    this.info = const Value.absent(),
    this.isInc = const Value.absent(),
    this.goodsCnt = const Value.absent(),
    this.mc = const Value.absent(),
    this.delivered = const Value.absent(),
    this.physical = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int ord,
    required String ndoc,
    required String info,
    required bool isInc,
    required int goodsCnt,
    required double mc,
    this.delivered = const Value.absent(),
    required bool physical,
  })  : buyerId = Value(buyerId),
        ord = Value(ord),
        ndoc = Value(ndoc),
        info = Value(info),
        isInc = Value(isInc),
        goodsCnt = Value(goodsCnt),
        mc = Value(mc),
        physical = Value(physical);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? ord,
    Expression<String>? ndoc,
    Expression<String>? info,
    Expression<bool>? isInc,
    Expression<int>? goodsCnt,
    Expression<double>? mc,
    Expression<bool?>? delivered,
    Expression<bool>? physical,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (ord != null) 'ord': ord,
      if (ndoc != null) 'ndoc': ndoc,
      if (info != null) 'info': info,
      if (isInc != null) 'is_inc': isInc,
      if (goodsCnt != null) 'goods_cnt': goodsCnt,
      if (mc != null) 'mc': mc,
      if (delivered != null) 'delivered': delivered,
      if (physical != null) 'physical': physical,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<int>? buyerId,
      Value<int>? ord,
      Value<String>? ndoc,
      Value<String>? info,
      Value<bool>? isInc,
      Value<int>? goodsCnt,
      Value<double>? mc,
      Value<bool?>? delivered,
      Value<bool>? physical}) {
    return OrdersCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      ord: ord ?? this.ord,
      ndoc: ndoc ?? this.ndoc,
      info: info ?? this.info,
      isInc: isInc ?? this.isInc,
      goodsCnt: goodsCnt ?? this.goodsCnt,
      mc: mc ?? this.mc,
      delivered: delivered ?? this.delivered,
      physical: physical ?? this.physical,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (ord.present) {
      map['ord'] = Variable<int>(ord.value);
    }
    if (ndoc.present) {
      map['ndoc'] = Variable<String>(ndoc.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    if (isInc.present) {
      map['is_inc'] = Variable<bool>(isInc.value);
    }
    if (goodsCnt.present) {
      map['goods_cnt'] = Variable<int>(goodsCnt.value);
    }
    if (mc.present) {
      map['mc'] = Variable<double>(mc.value);
    }
    if (delivered.present) {
      map['delivered'] = Variable<bool?>(delivered.value);
    }
    if (physical.present) {
      map['physical'] = Variable<bool>(physical.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('ord: $ord, ')
          ..write('ndoc: $ndoc, ')
          ..write('info: $info, ')
          ..write('isInc: $isInc, ')
          ..write('goodsCnt: $goodsCnt, ')
          ..write('mc: $mc, ')
          ..write('delivered: $delivered, ')
          ..write('physical: $physical')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _buyerIdMeta = const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<int?> buyerId = GeneratedColumn<int?>(
      'buyer_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _ordMeta = const VerificationMeta('ord');
  @override
  late final GeneratedColumn<int?> ord = GeneratedColumn<int?>(
      'ord', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _ndocMeta = const VerificationMeta('ndoc');
  @override
  late final GeneratedColumn<String?> ndoc = GeneratedColumn<String?>(
      'ndoc', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String?> info = GeneratedColumn<String?>(
      'info', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isIncMeta = const VerificationMeta('isInc');
  @override
  late final GeneratedColumn<bool?> isInc = GeneratedColumn<bool?>(
      'is_inc', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_inc IN (0, 1))');
  final VerificationMeta _goodsCntMeta = const VerificationMeta('goodsCnt');
  @override
  late final GeneratedColumn<int?> goodsCnt = GeneratedColumn<int?>(
      'goods_cnt', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _mcMeta = const VerificationMeta('mc');
  @override
  late final GeneratedColumn<double?> mc = GeneratedColumn<double?>(
      'mc', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _deliveredMeta = const VerificationMeta('delivered');
  @override
  late final GeneratedColumn<bool?> delivered = GeneratedColumn<bool?>(
      'delivered', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (delivered IN (0, 1))');
  final VerificationMeta _physicalMeta = const VerificationMeta('physical');
  @override
  late final GeneratedColumn<bool?> physical = GeneratedColumn<bool?>(
      'physical', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (physical IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, buyerId, ord, ndoc, info, isInc, goodsCnt, mc, delivered, physical];
  @override
  String get aliasedName => _alias ?? 'orders';
  @override
  String get actualTableName => 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('ord')) {
      context.handle(
          _ordMeta, ord.isAcceptableOrUnknown(data['ord']!, _ordMeta));
    } else if (isInserting) {
      context.missing(_ordMeta);
    }
    if (data.containsKey('ndoc')) {
      context.handle(
          _ndocMeta, ndoc.isAcceptableOrUnknown(data['ndoc']!, _ndocMeta));
    } else if (isInserting) {
      context.missing(_ndocMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
          _infoMeta, info.isAcceptableOrUnknown(data['info']!, _infoMeta));
    } else if (isInserting) {
      context.missing(_infoMeta);
    }
    if (data.containsKey('is_inc')) {
      context.handle(
          _isIncMeta, isInc.isAcceptableOrUnknown(data['is_inc']!, _isIncMeta));
    } else if (isInserting) {
      context.missing(_isIncMeta);
    }
    if (data.containsKey('goods_cnt')) {
      context.handle(_goodsCntMeta,
          goodsCnt.isAcceptableOrUnknown(data['goods_cnt']!, _goodsCntMeta));
    } else if (isInserting) {
      context.missing(_goodsCntMeta);
    }
    if (data.containsKey('mc')) {
      context.handle(_mcMeta, mc.isAcceptableOrUnknown(data['mc']!, _mcMeta));
    } else if (isInserting) {
      context.missing(_mcMeta);
    }
    if (data.containsKey('delivered')) {
      context.handle(_deliveredMeta,
          delivered.isAcceptableOrUnknown(data['delivered']!, _deliveredMeta));
    }
    if (data.containsKey('physical')) {
      context.handle(_physicalMeta,
          physical.isAcceptableOrUnknown(data['physical']!, _physicalMeta));
    } else if (isInserting) {
      context.missing(_physicalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Order.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderLine extends DataClass implements Insertable<OrderLine> {
  final int orderId;
  final int subid;
  final String name;
  final String gtin;
  final double vol;
  final double deliveredVol;
  final double price;
  final bool needMarking;
  final List<OrderLineBarcode> barcodeRels;
  OrderLine(
      {required this.orderId,
      required this.subid,
      required this.name,
      required this.gtin,
      required this.vol,
      required this.deliveredVol,
      required this.price,
      required this.needMarking,
      required this.barcodeRels});
  factory OrderLine.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrderLine(
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      subid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subid'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      gtin: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gtin'])!,
      vol: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vol'])!,
      deliveredVol: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivered_vol'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      needMarking: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}need_marking'])!,
      barcodeRels: $OrderLinesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}barcode_rels']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['subid'] = Variable<int>(subid);
    map['name'] = Variable<String>(name);
    map['gtin'] = Variable<String>(gtin);
    map['vol'] = Variable<double>(vol);
    map['delivered_vol'] = Variable<double>(deliveredVol);
    map['price'] = Variable<double>(price);
    map['need_marking'] = Variable<bool>(needMarking);
    {
      final converter = $OrderLinesTable.$converter0;
      map['barcode_rels'] = Variable<String>(converter.mapToSql(barcodeRels)!);
    }
    return map;
  }

  OrderLinesCompanion toCompanion(bool nullToAbsent) {
    return OrderLinesCompanion(
      orderId: Value(orderId),
      subid: Value(subid),
      name: Value(name),
      gtin: Value(gtin),
      vol: Value(vol),
      deliveredVol: Value(deliveredVol),
      price: Value(price),
      needMarking: Value(needMarking),
      barcodeRels: Value(barcodeRels),
    );
  }

  factory OrderLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLine(
      orderId: serializer.fromJson<int>(json['orderId']),
      subid: serializer.fromJson<int>(json['subid']),
      name: serializer.fromJson<String>(json['name']),
      gtin: serializer.fromJson<String>(json['gtin']),
      vol: serializer.fromJson<double>(json['vol']),
      deliveredVol: serializer.fromJson<double>(json['deliveredVol']),
      price: serializer.fromJson<double>(json['price']),
      needMarking: serializer.fromJson<bool>(json['needMarking']),
      barcodeRels:
          serializer.fromJson<List<OrderLineBarcode>>(json['barcodeRels']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'subid': serializer.toJson<int>(subid),
      'name': serializer.toJson<String>(name),
      'gtin': serializer.toJson<String>(gtin),
      'vol': serializer.toJson<double>(vol),
      'deliveredVol': serializer.toJson<double>(deliveredVol),
      'price': serializer.toJson<double>(price),
      'needMarking': serializer.toJson<bool>(needMarking),
      'barcodeRels': serializer.toJson<List<OrderLineBarcode>>(barcodeRels),
    };
  }

  OrderLine copyWith(
          {int? orderId,
          int? subid,
          String? name,
          String? gtin,
          double? vol,
          double? deliveredVol,
          double? price,
          bool? needMarking,
          List<OrderLineBarcode>? barcodeRels}) =>
      OrderLine(
        orderId: orderId ?? this.orderId,
        subid: subid ?? this.subid,
        name: name ?? this.name,
        gtin: gtin ?? this.gtin,
        vol: vol ?? this.vol,
        deliveredVol: deliveredVol ?? this.deliveredVol,
        price: price ?? this.price,
        needMarking: needMarking ?? this.needMarking,
        barcodeRels: barcodeRels ?? this.barcodeRels,
      );
  @override
  String toString() {
    return (StringBuffer('OrderLine(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('name: $name, ')
          ..write('gtin: $gtin, ')
          ..write('vol: $vol, ')
          ..write('deliveredVol: $deliveredVol, ')
          ..write('price: $price, ')
          ..write('needMarking: $needMarking, ')
          ..write('barcodeRels: $barcodeRels')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(orderId, subid, name, gtin, vol, deliveredVol,
      price, needMarking, barcodeRels);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLine &&
          other.orderId == this.orderId &&
          other.subid == this.subid &&
          other.name == this.name &&
          other.gtin == this.gtin &&
          other.vol == this.vol &&
          other.deliveredVol == this.deliveredVol &&
          other.price == this.price &&
          other.needMarking == this.needMarking &&
          other.barcodeRels == this.barcodeRels);
}

class OrderLinesCompanion extends UpdateCompanion<OrderLine> {
  final Value<int> orderId;
  final Value<int> subid;
  final Value<String> name;
  final Value<String> gtin;
  final Value<double> vol;
  final Value<double> deliveredVol;
  final Value<double> price;
  final Value<bool> needMarking;
  final Value<List<OrderLineBarcode>> barcodeRels;
  const OrderLinesCompanion({
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.name = const Value.absent(),
    this.gtin = const Value.absent(),
    this.vol = const Value.absent(),
    this.deliveredVol = const Value.absent(),
    this.price = const Value.absent(),
    this.needMarking = const Value.absent(),
    this.barcodeRels = const Value.absent(),
  });
  OrderLinesCompanion.insert({
    required int orderId,
    required int subid,
    required String name,
    required String gtin,
    required double vol,
    required double deliveredVol,
    required double price,
    required bool needMarking,
    required List<OrderLineBarcode> barcodeRels,
  })  : orderId = Value(orderId),
        subid = Value(subid),
        name = Value(name),
        gtin = Value(gtin),
        vol = Value(vol),
        deliveredVol = Value(deliveredVol),
        price = Value(price),
        needMarking = Value(needMarking),
        barcodeRels = Value(barcodeRels);
  static Insertable<OrderLine> custom({
    Expression<int>? orderId,
    Expression<int>? subid,
    Expression<String>? name,
    Expression<String>? gtin,
    Expression<double>? vol,
    Expression<double>? deliveredVol,
    Expression<double>? price,
    Expression<bool>? needMarking,
    Expression<List<OrderLineBarcode>>? barcodeRels,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (name != null) 'name': name,
      if (gtin != null) 'gtin': gtin,
      if (vol != null) 'vol': vol,
      if (deliveredVol != null) 'delivered_vol': deliveredVol,
      if (price != null) 'price': price,
      if (needMarking != null) 'need_marking': needMarking,
      if (barcodeRels != null) 'barcode_rels': barcodeRels,
    });
  }

  OrderLinesCompanion copyWith(
      {Value<int>? orderId,
      Value<int>? subid,
      Value<String>? name,
      Value<String>? gtin,
      Value<double>? vol,
      Value<double>? deliveredVol,
      Value<double>? price,
      Value<bool>? needMarking,
      Value<List<OrderLineBarcode>>? barcodeRels}) {
    return OrderLinesCompanion(
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      name: name ?? this.name,
      gtin: gtin ?? this.gtin,
      vol: vol ?? this.vol,
      deliveredVol: deliveredVol ?? this.deliveredVol,
      price: price ?? this.price,
      needMarking: needMarking ?? this.needMarking,
      barcodeRels: barcodeRels ?? this.barcodeRels,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (subid.present) {
      map['subid'] = Variable<int>(subid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gtin.present) {
      map['gtin'] = Variable<String>(gtin.value);
    }
    if (vol.present) {
      map['vol'] = Variable<double>(vol.value);
    }
    if (deliveredVol.present) {
      map['delivered_vol'] = Variable<double>(deliveredVol.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (needMarking.present) {
      map['need_marking'] = Variable<bool>(needMarking.value);
    }
    if (barcodeRels.present) {
      final converter = $OrderLinesTable.$converter0;
      map['barcode_rels'] =
          Variable<String>(converter.mapToSql(barcodeRels.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinesCompanion(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('name: $name, ')
          ..write('gtin: $gtin, ')
          ..write('vol: $vol, ')
          ..write('deliveredVol: $deliveredVol, ')
          ..write('price: $price, ')
          ..write('needMarking: $needMarking, ')
          ..write('barcodeRels: $barcodeRels')
          ..write(')'))
        .toString();
  }
}

class $OrderLinesTable extends OrderLines
    with TableInfo<$OrderLinesTable, OrderLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int?> subid = GeneratedColumn<int?>(
      'subid', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _gtinMeta = const VerificationMeta('gtin');
  @override
  late final GeneratedColumn<String?> gtin = GeneratedColumn<String?>(
      'gtin', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _volMeta = const VerificationMeta('vol');
  @override
  late final GeneratedColumn<double?> vol = GeneratedColumn<double?>(
      'vol', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _deliveredVolMeta =
      const VerificationMeta('deliveredVol');
  @override
  late final GeneratedColumn<double?> deliveredVol = GeneratedColumn<double?>(
      'delivered_vol', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _needMarkingMeta =
      const VerificationMeta('needMarking');
  @override
  late final GeneratedColumn<bool?> needMarking = GeneratedColumn<bool?>(
      'need_marking', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (need_marking IN (0, 1))');
  final VerificationMeta _barcodeRelsMeta =
      const VerificationMeta('barcodeRels');
  @override
  late final GeneratedColumnWithTypeConverter<List<OrderLineBarcode>, String?>
      barcodeRels = GeneratedColumn<String?>('barcode_rels', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<OrderLineBarcode>>($OrderLinesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [
        orderId,
        subid,
        name,
        gtin,
        vol,
        deliveredVol,
        price,
        needMarking,
        barcodeRels
      ];
  @override
  String get aliasedName => _alias ?? 'order_lines';
  @override
  String get actualTableName => 'order_lines';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
          _subidMeta, subid.isAcceptableOrUnknown(data['subid']!, _subidMeta));
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gtin')) {
      context.handle(
          _gtinMeta, gtin.isAcceptableOrUnknown(data['gtin']!, _gtinMeta));
    } else if (isInserting) {
      context.missing(_gtinMeta);
    }
    if (data.containsKey('vol')) {
      context.handle(
          _volMeta, vol.isAcceptableOrUnknown(data['vol']!, _volMeta));
    } else if (isInserting) {
      context.missing(_volMeta);
    }
    if (data.containsKey('delivered_vol')) {
      context.handle(
          _deliveredVolMeta,
          deliveredVol.isAcceptableOrUnknown(
              data['delivered_vol']!, _deliveredVolMeta));
    } else if (isInserting) {
      context.missing(_deliveredVolMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('need_marking')) {
      context.handle(
          _needMarkingMeta,
          needMarking.isAcceptableOrUnknown(
              data['need_marking']!, _needMarkingMeta));
    } else if (isInserting) {
      context.missing(_needMarkingMeta);
    }
    context.handle(_barcodeRelsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid};
  @override
  OrderLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrderLine.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<OrderLineBarcode>, String> $converter0 =
      const OrderLineBarcodeListConverter();
}

class OrderLineCode extends DataClass implements Insertable<OrderLineCode> {
  final int orderId;
  final int subid;
  final String code;
  final int amount;
  final bool isDataMatrix;
  final DateTime localTs;
  OrderLineCode(
      {required this.orderId,
      required this.subid,
      required this.code,
      required this.amount,
      required this.isDataMatrix,
      required this.localTs});
  factory OrderLineCode.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrderLineCode(
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      subid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subid'])!,
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      isDataMatrix: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_data_matrix'])!,
      localTs: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_ts'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['subid'] = Variable<int>(subid);
    map['code'] = Variable<String>(code);
    map['amount'] = Variable<int>(amount);
    map['is_data_matrix'] = Variable<bool>(isDataMatrix);
    map['local_ts'] = Variable<DateTime>(localTs);
    return map;
  }

  OrderLineCodesCompanion toCompanion(bool nullToAbsent) {
    return OrderLineCodesCompanion(
      orderId: Value(orderId),
      subid: Value(subid),
      code: Value(code),
      amount: Value(amount),
      isDataMatrix: Value(isDataMatrix),
      localTs: Value(localTs),
    );
  }

  factory OrderLineCode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLineCode(
      orderId: serializer.fromJson<int>(json['orderId']),
      subid: serializer.fromJson<int>(json['subid']),
      code: serializer.fromJson<String>(json['code']),
      amount: serializer.fromJson<int>(json['amount']),
      isDataMatrix: serializer.fromJson<bool>(json['isDataMatrix']),
      localTs: serializer.fromJson<DateTime>(json['localTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'subid': serializer.toJson<int>(subid),
      'code': serializer.toJson<String>(code),
      'amount': serializer.toJson<int>(amount),
      'isDataMatrix': serializer.toJson<bool>(isDataMatrix),
      'localTs': serializer.toJson<DateTime>(localTs),
    };
  }

  OrderLineCode copyWith(
          {int? orderId,
          int? subid,
          String? code,
          int? amount,
          bool? isDataMatrix,
          DateTime? localTs}) =>
      OrderLineCode(
        orderId: orderId ?? this.orderId,
        subid: subid ?? this.subid,
        code: code ?? this.code,
        amount: amount ?? this.amount,
        isDataMatrix: isDataMatrix ?? this.isDataMatrix,
        localTs: localTs ?? this.localTs,
      );
  @override
  String toString() {
    return (StringBuffer('OrderLineCode(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('amount: $amount, ')
          ..write('isDataMatrix: $isDataMatrix, ')
          ..write('localTs: $localTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(orderId, subid, code, amount, isDataMatrix, localTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLineCode &&
          other.orderId == this.orderId &&
          other.subid == this.subid &&
          other.code == this.code &&
          other.amount == this.amount &&
          other.isDataMatrix == this.isDataMatrix &&
          other.localTs == this.localTs);
}

class OrderLineCodesCompanion extends UpdateCompanion<OrderLineCode> {
  final Value<int> orderId;
  final Value<int> subid;
  final Value<String> code;
  final Value<int> amount;
  final Value<bool> isDataMatrix;
  final Value<DateTime> localTs;
  const OrderLineCodesCompanion({
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.code = const Value.absent(),
    this.amount = const Value.absent(),
    this.isDataMatrix = const Value.absent(),
    this.localTs = const Value.absent(),
  });
  OrderLineCodesCompanion.insert({
    required int orderId,
    required int subid,
    required String code,
    required int amount,
    required bool isDataMatrix,
    required DateTime localTs,
  })  : orderId = Value(orderId),
        subid = Value(subid),
        code = Value(code),
        amount = Value(amount),
        isDataMatrix = Value(isDataMatrix),
        localTs = Value(localTs);
  static Insertable<OrderLineCode> custom({
    Expression<int>? orderId,
    Expression<int>? subid,
    Expression<String>? code,
    Expression<int>? amount,
    Expression<bool>? isDataMatrix,
    Expression<DateTime>? localTs,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (code != null) 'code': code,
      if (amount != null) 'amount': amount,
      if (isDataMatrix != null) 'is_data_matrix': isDataMatrix,
      if (localTs != null) 'local_ts': localTs,
    });
  }

  OrderLineCodesCompanion copyWith(
      {Value<int>? orderId,
      Value<int>? subid,
      Value<String>? code,
      Value<int>? amount,
      Value<bool>? isDataMatrix,
      Value<DateTime>? localTs}) {
    return OrderLineCodesCompanion(
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      code: code ?? this.code,
      amount: amount ?? this.amount,
      isDataMatrix: isDataMatrix ?? this.isDataMatrix,
      localTs: localTs ?? this.localTs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (subid.present) {
      map['subid'] = Variable<int>(subid.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (isDataMatrix.present) {
      map['is_data_matrix'] = Variable<bool>(isDataMatrix.value);
    }
    if (localTs.present) {
      map['local_ts'] = Variable<DateTime>(localTs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineCodesCompanion(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('amount: $amount, ')
          ..write('isDataMatrix: $isDataMatrix, ')
          ..write('localTs: $localTs')
          ..write(')'))
        .toString();
  }
}

class $OrderLineCodesTable extends OrderLineCodes
    with TableInfo<$OrderLineCodesTable, OrderLineCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLineCodesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int?> subid = GeneratedColumn<int?>(
      'subid', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isDataMatrixMeta =
      const VerificationMeta('isDataMatrix');
  @override
  late final GeneratedColumn<bool?> isDataMatrix = GeneratedColumn<bool?>(
      'is_data_matrix', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_data_matrix IN (0, 1))');
  final VerificationMeta _localTsMeta = const VerificationMeta('localTs');
  @override
  late final GeneratedColumn<DateTime?> localTs = GeneratedColumn<DateTime?>(
      'local_ts', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [orderId, subid, code, amount, isDataMatrix, localTs];
  @override
  String get aliasedName => _alias ?? 'order_line_codes';
  @override
  String get actualTableName => 'order_line_codes';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLineCode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
          _subidMeta, subid.isAcceptableOrUnknown(data['subid']!, _subidMeta));
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_data_matrix')) {
      context.handle(
          _isDataMatrixMeta,
          isDataMatrix.isAcceptableOrUnknown(
              data['is_data_matrix']!, _isDataMatrixMeta));
    } else if (isInserting) {
      context.missing(_isDataMatrixMeta);
    }
    if (data.containsKey('local_ts')) {
      context.handle(_localTsMeta,
          localTs.isAcceptableOrUnknown(data['local_ts']!, _localTsMeta));
    } else if (isInserting) {
      context.missing(_localTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid, code};
  @override
  OrderLineCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrderLineCode.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrderLineCodesTable createAlias(String alias) {
    return $OrderLineCodesTable(attachedDatabase, alias);
  }
}

class Pref extends DataClass implements Insertable<Pref> {
  final DateTime? lastSyncTime;
  Pref({this.lastSyncTime});
  factory Pref.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Pref(
      lastSyncTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_sync_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || lastSyncTime != null) {
      map['last_sync_time'] = Variable<DateTime?>(lastSyncTime);
    }
    return map;
  }

  PrefsCompanion toCompanion(bool nullToAbsent) {
    return PrefsCompanion(
      lastSyncTime: lastSyncTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncTime),
    );
  }

  factory Pref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pref(
      lastSyncTime: serializer.fromJson<DateTime?>(json['lastSyncTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lastSyncTime': serializer.toJson<DateTime?>(lastSyncTime),
    };
  }

  Pref copyWith({DateTime? lastSyncTime}) => Pref(
        lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      );
  @override
  String toString() {
    return (StringBuffer('Pref(')
          ..write('lastSyncTime: $lastSyncTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => lastSyncTime.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pref && other.lastSyncTime == this.lastSyncTime);
}

class PrefsCompanion extends UpdateCompanion<Pref> {
  final Value<DateTime?> lastSyncTime;
  const PrefsCompanion({
    this.lastSyncTime = const Value.absent(),
  });
  PrefsCompanion.insert({
    this.lastSyncTime = const Value.absent(),
  });
  static Insertable<Pref> custom({
    Expression<DateTime?>? lastSyncTime,
  }) {
    return RawValuesInsertable({
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
    });
  }

  PrefsCompanion copyWith({Value<DateTime?>? lastSyncTime}) {
    return PrefsCompanion(
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<DateTime?>(lastSyncTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrefsCompanion(')
          ..write('lastSyncTime: $lastSyncTime')
          ..write(')'))
        .toString();
  }
}

class $PrefsTable extends Prefs with TableInfo<$PrefsTable, Pref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrefsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _lastSyncTimeMeta =
      const VerificationMeta('lastSyncTime');
  @override
  late final GeneratedColumn<DateTime?> lastSyncTime =
      GeneratedColumn<DateTime?>('last_sync_time', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [lastSyncTime];
  @override
  String get aliasedName => _alias ?? 'prefs';
  @override
  String get actualTableName => 'prefs';
  @override
  VerificationContext validateIntegrity(Insertable<Pref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('last_sync_time')) {
      context.handle(
          _lastSyncTimeMeta,
          lastSyncTime.isAcceptableOrUnknown(
              data['last_sync_time']!, _lastSyncTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Pref map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Pref.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PrefsTable createAlias(String alias) {
    return $PrefsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDataStore extends GeneratedDatabase {
  _$AppDataStore(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $ReceptsTable recepts = $ReceptsTable(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $BuyersTable buyers = $BuyersTable(this);
  late final $CardPaymentsTable cardPayments = $CardPaymentsTable(this);
  late final $CashPaymentsTable cashPayments = $CashPaymentsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $OrderLineCodesTable orderLineCodes = $OrderLineCodesTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final OrdersDao ordersDao = OrdersDao(this as AppDataStore);
  late final PaymentsDao paymentsDao = PaymentsDao(this as AppDataStore);
  late final UsersDao usersDao = UsersDao(this as AppDataStore);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        recepts,
        incomes,
        buyers,
        cardPayments,
        cashPayments,
        debts,
        orders,
        orderLines,
        orderLineCodes,
        prefs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$OrdersDaoMixin on DatabaseAccessor<AppDataStore> {
  $BuyersTable get buyers => attachedDatabase.buyers;
  $IncomesTable get incomes => attachedDatabase.incomes;
  $ReceptsTable get recepts => attachedDatabase.recepts;
  $OrdersTable get orders => attachedDatabase.orders;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
  $OrderLineCodesTable get orderLineCodes => attachedDatabase.orderLineCodes;
}
mixin _$PaymentsDaoMixin on DatabaseAccessor<AppDataStore> {
  $DebtsTable get debts => attachedDatabase.debts;
  $CashPaymentsTable get cashPayments => attachedDatabase.cashPayments;
  $CardPaymentsTable get cardPayments => attachedDatabase.cardPayments;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppDataStore> {
  $UsersTable get users => attachedDatabase.users;
}
