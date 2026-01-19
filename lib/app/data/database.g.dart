// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salesmanNameMeta = const VerificationMeta(
    'salesmanName',
  );
  @override
  late final GeneratedColumn<String> salesmanName = GeneratedColumn<String>(
    'salesman_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedMeta = const VerificationMeta('closed');
  @override
  late final GeneratedColumn<bool> closed = GeneratedColumn<bool>(
    'closed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("closed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    salesmanName,
    email,
    closed,
    version,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('salesman_name')) {
      context.handle(
        _salesmanNameMeta,
        salesmanName.isAcceptableOrUnknown(
          data['salesman_name']!,
          _salesmanNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_salesmanNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('closed')) {
      context.handle(
        _closedMeta,
        closed.isAcceptableOrUnknown(data['closed']!, _closedMeta),
      );
    } else if (isInserting) {
      context.missing(_closedMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      salesmanName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}salesman_name'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      closed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}closed'],
          )!,
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}version'],
          )!,
      total:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total'],
          )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String salesmanName;
  final String email;
  final bool closed;
  final String version;
  final double total;
  const User({
    required this.id,
    required this.username,
    required this.salesmanName,
    required this.email,
    required this.closed,
    required this.version,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['salesman_name'] = Variable<String>(salesmanName);
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
      email: Value(email),
      closed: Value(closed),
      version: Value(version),
      total: Value(total),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      salesmanName: serializer.fromJson<String>(json['salesmanName']),
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
      'email': serializer.toJson<String>(email),
      'closed': serializer.toJson<bool>(closed),
      'version': serializer.toJson<String>(version),
      'total': serializer.toJson<double>(total),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? salesmanName,
    String? email,
    bool? closed,
    String? version,
    double? total,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    salesmanName: salesmanName ?? this.salesmanName,
    email: email ?? this.email,
    closed: closed ?? this.closed,
    version: version ?? this.version,
    total: total ?? this.total,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      salesmanName:
          data.salesmanName.present
              ? data.salesmanName.value
              : this.salesmanName,
      email: data.email.present ? data.email.value : this.email,
      closed: data.closed.present ? data.closed.value : this.closed,
      version: data.version.present ? data.version.value : this.version,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('salesmanName: $salesmanName, ')
          ..write('email: $email, ')
          ..write('closed: $closed, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, salesmanName, email, closed, version, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.salesmanName == this.salesmanName &&
          other.email == this.email &&
          other.closed == this.closed &&
          other.version == this.version &&
          other.total == this.total);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> salesmanName;
  final Value<String> email;
  final Value<bool> closed;
  final Value<String> version;
  final Value<double> total;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.salesmanName = const Value.absent(),
    this.email = const Value.absent(),
    this.closed = const Value.absent(),
    this.version = const Value.absent(),
    this.total = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String salesmanName,
    required String email,
    required bool closed,
    required String version,
    required double total,
  }) : username = Value(username),
       salesmanName = Value(salesmanName),
       email = Value(email),
       closed = Value(closed),
       version = Value(version),
       total = Value(total);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? salesmanName,
    Expression<String>? email,
    Expression<bool>? closed,
    Expression<String>? version,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (salesmanName != null) 'salesman_name': salesmanName,
      if (email != null) 'email': email,
      if (closed != null) 'closed': closed,
      if (version != null) 'version': version,
      if (total != null) 'total': total,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? salesmanName,
    Value<String>? email,
    Value<bool>? closed,
    Value<String>? version,
    Value<double>? total,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      salesmanName: salesmanName ?? this.salesmanName,
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
          ..write('email: $email, ')
          ..write('closed: $closed, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $ReceptsTable extends Recepts with TableInfo<$ReceptsTable, Recept> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime> ddate = GeneratedColumn<DateTime>(
    'ddate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double> summ = GeneratedColumn<double>(
    'summ',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ddate, summ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recepts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recept> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ddate')) {
      context.handle(
        _ddateMeta,
        ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta),
      );
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
        _summMeta,
        summ.isAcceptableOrUnknown(data['summ']!, _summMeta),
      );
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recept map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recept(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ddate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ddate'],
          )!,
      summ:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}summ'],
          )!,
    );
  }

  @override
  $ReceptsTable createAlias(String alias) {
    return $ReceptsTable(attachedDatabase, alias);
  }
}

class Recept extends DataClass implements Insertable<Recept> {
  final int id;
  final DateTime ddate;
  final double summ;
  const Recept({required this.id, required this.ddate, required this.summ});
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

  factory Recept.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
  Recept copyWithCompanion(ReceptsCompanion data) {
    return Recept(
      id: data.id.present ? data.id.value : this.id,
      ddate: data.ddate.present ? data.ddate.value : this.ddate,
      summ: data.summ.present ? data.summ.value : this.summ,
    );
  }

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
  }) : ddate = Value(ddate),
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

  ReceptsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? ddate,
    Value<double>? summ,
  }) {
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

class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime> ddate = GeneratedColumn<DateTime>(
    'ddate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double> summ = GeneratedColumn<double>(
    'summ',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ddate, summ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Income> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ddate')) {
      context.handle(
        _ddateMeta,
        ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta),
      );
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
        _summMeta,
        summ.isAcceptableOrUnknown(data['summ']!, _summMeta),
      );
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ddate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ddate'],
          )!,
      summ:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}summ'],
          )!,
    );
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }
}

class Income extends DataClass implements Insertable<Income> {
  final int id;
  final DateTime ddate;
  final double summ;
  const Income({required this.id, required this.ddate, required this.summ});
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

  factory Income.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
  Income copyWithCompanion(IncomesCompanion data) {
    return Income(
      id: data.id.present ? data.id.value : this.id,
      ddate: data.ddate.present ? data.ddate.value : this.ddate,
      summ: data.summ.present ? data.summ.value : this.summ,
    );
  }

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
  }) : ddate = Value(ddate),
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

  IncomesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? ddate,
    Value<double>? summ,
  }) {
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

class $BuyersTable extends Buyers with TableInfo<$BuyersTable, Buyer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryIdMeta = const VerificationMeta(
    'deliveryId',
  );
  @override
  late final GeneratedColumn<int> deliveryId = GeneratedColumn<int>(
    'delivery_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordMeta = const VerificationMeta('ord');
  @override
  late final GeneratedColumn<int> ord = GeneratedColumn<int>(
    'ord',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _needIncMeta = const VerificationMeta(
    'needInc',
  );
  @override
  late final GeneratedColumn<bool> needInc = GeneratedColumn<bool>(
    'need_inc',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("need_inc" IN (0, 1))',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupPhoneMeta = const VerificationMeta(
    'groupPhone',
  );
  @override
  late final GeneratedColumn<String> groupPhone = GeneratedColumn<String>(
    'group_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    buyerId,
    deliveryId,
    name,
    address,
    ord,
    needInc,
    latitude,
    longitude,
    groupName,
    groupPhone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buyers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Buyer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('delivery_id')) {
      context.handle(
        _deliveryIdMeta,
        deliveryId.isAcceptableOrUnknown(data['delivery_id']!, _deliveryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deliveryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('ord')) {
      context.handle(
        _ordMeta,
        ord.isAcceptableOrUnknown(data['ord']!, _ordMeta),
      );
    } else if (isInserting) {
      context.missing(_ordMeta);
    }
    if (data.containsKey('need_inc')) {
      context.handle(
        _needIncMeta,
        needInc.isAcceptableOrUnknown(data['need_inc']!, _needIncMeta),
      );
    } else if (isInserting) {
      context.missing(_needIncMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    if (data.containsKey('group_phone')) {
      context.handle(
        _groupPhoneMeta,
        groupPhone.isAcceptableOrUnknown(data['group_phone']!, _groupPhoneMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {buyerId, deliveryId};
  @override
  Buyer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Buyer(
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      deliveryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}delivery_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      address:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}address'],
          )!,
      ord:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ord'],
          )!,
      needInc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}need_inc'],
          )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      ),
      groupPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_phone'],
      ),
    );
  }

  @override
  $BuyersTable createAlias(String alias) {
    return $BuyersTable(attachedDatabase, alias);
  }
}

class Buyer extends DataClass implements Insertable<Buyer> {
  final int buyerId;
  final int deliveryId;
  final String name;
  final String address;
  final int ord;
  final bool needInc;
  final double? latitude;
  final double? longitude;
  final String? groupName;
  final String? groupPhone;
  const Buyer({
    required this.buyerId,
    required this.deliveryId,
    required this.name,
    required this.address,
    required this.ord,
    required this.needInc,
    this.latitude,
    this.longitude,
    this.groupName,
    this.groupPhone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['buyer_id'] = Variable<int>(buyerId);
    map['delivery_id'] = Variable<int>(deliveryId);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['ord'] = Variable<int>(ord);
    map['need_inc'] = Variable<bool>(needInc);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    if (!nullToAbsent || groupPhone != null) {
      map['group_phone'] = Variable<String>(groupPhone);
    }
    return map;
  }

  BuyersCompanion toCompanion(bool nullToAbsent) {
    return BuyersCompanion(
      buyerId: Value(buyerId),
      deliveryId: Value(deliveryId),
      name: Value(name),
      address: Value(address),
      ord: Value(ord),
      needInc: Value(needInc),
      latitude:
          latitude == null && nullToAbsent
              ? const Value.absent()
              : Value(latitude),
      longitude:
          longitude == null && nullToAbsent
              ? const Value.absent()
              : Value(longitude),
      groupName:
          groupName == null && nullToAbsent
              ? const Value.absent()
              : Value(groupName),
      groupPhone:
          groupPhone == null && nullToAbsent
              ? const Value.absent()
              : Value(groupPhone),
    );
  }

  factory Buyer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Buyer(
      buyerId: serializer.fromJson<int>(json['buyerId']),
      deliveryId: serializer.fromJson<int>(json['deliveryId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      ord: serializer.fromJson<int>(json['ord']),
      needInc: serializer.fromJson<bool>(json['needInc']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      groupPhone: serializer.fromJson<String?>(json['groupPhone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'buyerId': serializer.toJson<int>(buyerId),
      'deliveryId': serializer.toJson<int>(deliveryId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'ord': serializer.toJson<int>(ord),
      'needInc': serializer.toJson<bool>(needInc),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'groupName': serializer.toJson<String?>(groupName),
      'groupPhone': serializer.toJson<String?>(groupPhone),
    };
  }

  Buyer copyWith({
    int? buyerId,
    int? deliveryId,
    String? name,
    String? address,
    int? ord,
    bool? needInc,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> groupName = const Value.absent(),
    Value<String?> groupPhone = const Value.absent(),
  }) => Buyer(
    buyerId: buyerId ?? this.buyerId,
    deliveryId: deliveryId ?? this.deliveryId,
    name: name ?? this.name,
    address: address ?? this.address,
    ord: ord ?? this.ord,
    needInc: needInc ?? this.needInc,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    groupName: groupName.present ? groupName.value : this.groupName,
    groupPhone: groupPhone.present ? groupPhone.value : this.groupPhone,
  );
  Buyer copyWithCompanion(BuyersCompanion data) {
    return Buyer(
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      deliveryId:
          data.deliveryId.present ? data.deliveryId.value : this.deliveryId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      ord: data.ord.present ? data.ord.value : this.ord,
      needInc: data.needInc.present ? data.needInc.value : this.needInc,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      groupPhone:
          data.groupPhone.present ? data.groupPhone.value : this.groupPhone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Buyer(')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('ord: $ord, ')
          ..write('needInc: $needInc, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('groupName: $groupName, ')
          ..write('groupPhone: $groupPhone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    buyerId,
    deliveryId,
    name,
    address,
    ord,
    needInc,
    latitude,
    longitude,
    groupName,
    groupPhone,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Buyer &&
          other.buyerId == this.buyerId &&
          other.deliveryId == this.deliveryId &&
          other.name == this.name &&
          other.address == this.address &&
          other.ord == this.ord &&
          other.needInc == this.needInc &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.groupName == this.groupName &&
          other.groupPhone == this.groupPhone);
}

class BuyersCompanion extends UpdateCompanion<Buyer> {
  final Value<int> buyerId;
  final Value<int> deliveryId;
  final Value<String> name;
  final Value<String> address;
  final Value<int> ord;
  final Value<bool> needInc;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> groupName;
  final Value<String?> groupPhone;
  final Value<int> rowid;
  const BuyersCompanion({
    this.buyerId = const Value.absent(),
    this.deliveryId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.ord = const Value.absent(),
    this.needInc = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.groupName = const Value.absent(),
    this.groupPhone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BuyersCompanion.insert({
    required int buyerId,
    required int deliveryId,
    required String name,
    required String address,
    required int ord,
    required bool needInc,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.groupName = const Value.absent(),
    this.groupPhone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : buyerId = Value(buyerId),
       deliveryId = Value(deliveryId),
       name = Value(name),
       address = Value(address),
       ord = Value(ord),
       needInc = Value(needInc);
  static Insertable<Buyer> custom({
    Expression<int>? buyerId,
    Expression<int>? deliveryId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? ord,
    Expression<bool>? needInc,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? groupName,
    Expression<String>? groupPhone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (buyerId != null) 'buyer_id': buyerId,
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (ord != null) 'ord': ord,
      if (needInc != null) 'need_inc': needInc,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (groupName != null) 'group_name': groupName,
      if (groupPhone != null) 'group_phone': groupPhone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BuyersCompanion copyWith({
    Value<int>? buyerId,
    Value<int>? deliveryId,
    Value<String>? name,
    Value<String>? address,
    Value<int>? ord,
    Value<bool>? needInc,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? groupName,
    Value<String?>? groupPhone,
    Value<int>? rowid,
  }) {
    return BuyersCompanion(
      buyerId: buyerId ?? this.buyerId,
      deliveryId: deliveryId ?? this.deliveryId,
      name: name ?? this.name,
      address: address ?? this.address,
      ord: ord ?? this.ord,
      needInc: needInc ?? this.needInc,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      groupName: groupName ?? this.groupName,
      groupPhone: groupPhone ?? this.groupPhone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (deliveryId.present) {
      map['delivery_id'] = Variable<int>(deliveryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (ord.present) {
      map['ord'] = Variable<int>(ord.value);
    }
    if (needInc.present) {
      map['need_inc'] = Variable<bool>(needInc.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (groupPhone.present) {
      map['group_phone'] = Variable<String>(groupPhone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyersCompanion(')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('ord: $ord, ')
          ..write('needInc: $needInc, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('groupName: $groupName, ')
          ..write('groupPhone: $groupPhone, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summMeta = const VerificationMeta('summ');
  @override
  late final GeneratedColumn<double> summ = GeneratedColumn<double>(
    'summ',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime> ddate = GeneratedColumn<DateTime>(
    'ddate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kkmprintedMeta = const VerificationMeta(
    'kkmprinted',
  );
  @override
  late final GeneratedColumn<bool> kkmprinted = GeneratedColumn<bool>(
    'kkmprinted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("kkmprinted" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buyerId,
    orderId,
    summ,
    ddate,
    kkmprinted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('summ')) {
      context.handle(
        _summMeta,
        summ.isAcceptableOrUnknown(data['summ']!, _summMeta),
      );
    } else if (isInserting) {
      context.missing(_summMeta);
    }
    if (data.containsKey('ddate')) {
      context.handle(
        _ddateMeta,
        ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta),
      );
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('kkmprinted')) {
      context.handle(
        _kkmprintedMeta,
        kkmprinted.isAcceptableOrUnknown(data['kkmprinted']!, _kkmprintedMeta),
      );
    } else if (isInserting) {
      context.missing(_kkmprintedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashPayment(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      summ:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}summ'],
          )!,
      ddate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ddate'],
          )!,
      kkmprinted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}kkmprinted'],
          )!,
    );
  }

  @override
  $CashPaymentsTable createAlias(String alias) {
    return $CashPaymentsTable(attachedDatabase, alias);
  }
}

class CashPayment extends DataClass implements Insertable<CashPayment> {
  final int id;
  final int buyerId;
  final int orderId;
  final double summ;
  final DateTime ddate;
  final bool kkmprinted;
  const CashPayment({
    required this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    required this.kkmprinted,
  });
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

  factory CashPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  CashPayment copyWith({
    int? id,
    int? buyerId,
    int? orderId,
    double? summ,
    DateTime? ddate,
    bool? kkmprinted,
  }) => CashPayment(
    id: id ?? this.id,
    buyerId: buyerId ?? this.buyerId,
    orderId: orderId ?? this.orderId,
    summ: summ ?? this.summ,
    ddate: ddate ?? this.ddate,
    kkmprinted: kkmprinted ?? this.kkmprinted,
  );
  CashPayment copyWithCompanion(CashPaymentsCompanion data) {
    return CashPayment(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      summ: data.summ.present ? data.summ.value : this.summ,
      ddate: data.ddate.present ? data.ddate.value : this.ddate,
      kkmprinted:
          data.kkmprinted.present ? data.kkmprinted.value : this.kkmprinted,
    );
  }

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
  }) : buyerId = Value(buyerId),
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

  CashPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? buyerId,
    Value<int>? orderId,
    Value<double>? summ,
    Value<DateTime>? ddate,
    Value<bool>? kkmprinted,
  }) {
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

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ndocMeta = const VerificationMeta('ndoc');
  @override
  late final GeneratedColumn<String> ndoc = GeneratedColumn<String>(
    'ndoc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderNdocMeta = const VerificationMeta(
    'orderNdoc',
  );
  @override
  late final GeneratedColumn<String> orderNdoc = GeneratedColumn<String>(
    'order_ndoc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ddateMeta = const VerificationMeta('ddate');
  @override
  late final GeneratedColumn<DateTime> ddate = GeneratedColumn<DateTime>(
    'ddate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderDdateMeta = const VerificationMeta(
    'orderDdate',
  );
  @override
  late final GeneratedColumn<DateTime> orderDdate = GeneratedColumn<DateTime>(
    'order_ddate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCheckMeta = const VerificationMeta(
    'isCheck',
  );
  @override
  late final GeneratedColumn<bool> isCheck = GeneratedColumn<bool>(
    'is_check',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_check" IN (0, 1))',
    ),
  );
  static const VerificationMeta _debtSumMeta = const VerificationMeta(
    'debtSum',
  );
  @override
  late final GeneratedColumn<double> debtSum = GeneratedColumn<double>(
    'debt_sum',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderSumMeta = const VerificationMeta(
    'orderSum',
  );
  @override
  late final GeneratedColumn<double> orderSum = GeneratedColumn<double>(
    'order_sum',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidSumMeta = const VerificationMeta(
    'paidSum',
  );
  @override
  late final GeneratedColumn<double> paidSum = GeneratedColumn<double>(
    'paid_sum',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentSumMeta = const VerificationMeta(
    'paymentSum',
  );
  @override
  late final GeneratedColumn<double> paymentSum = GeneratedColumn<double>(
    'payment_sum',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _physicalMeta = const VerificationMeta(
    'physical',
  );
  @override
  late final GeneratedColumn<bool> physical = GeneratedColumn<bool>(
    'physical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("physical" IN (0, 1))',
    ),
  );
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
    physical,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Debt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('ndoc')) {
      context.handle(
        _ndocMeta,
        ndoc.isAcceptableOrUnknown(data['ndoc']!, _ndocMeta),
      );
    } else if (isInserting) {
      context.missing(_ndocMeta);
    }
    if (data.containsKey('order_ndoc')) {
      context.handle(
        _orderNdocMeta,
        orderNdoc.isAcceptableOrUnknown(data['order_ndoc']!, _orderNdocMeta),
      );
    } else if (isInserting) {
      context.missing(_orderNdocMeta);
    }
    if (data.containsKey('ddate')) {
      context.handle(
        _ddateMeta,
        ddate.isAcceptableOrUnknown(data['ddate']!, _ddateMeta),
      );
    } else if (isInserting) {
      context.missing(_ddateMeta);
    }
    if (data.containsKey('order_ddate')) {
      context.handle(
        _orderDdateMeta,
        orderDdate.isAcceptableOrUnknown(data['order_ddate']!, _orderDdateMeta),
      );
    } else if (isInserting) {
      context.missing(_orderDdateMeta);
    }
    if (data.containsKey('is_check')) {
      context.handle(
        _isCheckMeta,
        isCheck.isAcceptableOrUnknown(data['is_check']!, _isCheckMeta),
      );
    } else if (isInserting) {
      context.missing(_isCheckMeta);
    }
    if (data.containsKey('debt_sum')) {
      context.handle(
        _debtSumMeta,
        debtSum.isAcceptableOrUnknown(data['debt_sum']!, _debtSumMeta),
      );
    } else if (isInserting) {
      context.missing(_debtSumMeta);
    }
    if (data.containsKey('order_sum')) {
      context.handle(
        _orderSumMeta,
        orderSum.isAcceptableOrUnknown(data['order_sum']!, _orderSumMeta),
      );
    } else if (isInserting) {
      context.missing(_orderSumMeta);
    }
    if (data.containsKey('paid_sum')) {
      context.handle(
        _paidSumMeta,
        paidSum.isAcceptableOrUnknown(data['paid_sum']!, _paidSumMeta),
      );
    }
    if (data.containsKey('payment_sum')) {
      context.handle(
        _paymentSumMeta,
        paymentSum.isAcceptableOrUnknown(data['payment_sum']!, _paymentSumMeta),
      );
    }
    if (data.containsKey('physical')) {
      context.handle(
        _physicalMeta,
        physical.isAcceptableOrUnknown(data['physical']!, _physicalMeta),
      );
    } else if (isInserting) {
      context.missing(_physicalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      ndoc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ndoc'],
          )!,
      orderNdoc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}order_ndoc'],
          )!,
      ddate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ddate'],
          )!,
      orderDdate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}order_ddate'],
          )!,
      isCheck:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_check'],
          )!,
      debtSum:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}debt_sum'],
          )!,
      orderSum:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}order_sum'],
          )!,
      paidSum: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_sum'],
      ),
      paymentSum: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payment_sum'],
      ),
      physical:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}physical'],
          )!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
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
  const Debt({
    required this.id,
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
    required this.physical,
  });
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
      map['paid_sum'] = Variable<double>(paidSum);
    }
    if (!nullToAbsent || paymentSum != null) {
      map['payment_sum'] = Variable<double>(paymentSum);
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
      paidSum:
          paidSum == null && nullToAbsent
              ? const Value.absent()
              : Value(paidSum),
      paymentSum:
          paymentSum == null && nullToAbsent
              ? const Value.absent()
              : Value(paymentSum),
      physical: Value(physical),
    );
  }

  factory Debt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  Debt copyWith({
    int? id,
    int? buyerId,
    int? orderId,
    String? ndoc,
    String? orderNdoc,
    DateTime? ddate,
    DateTime? orderDdate,
    bool? isCheck,
    double? debtSum,
    double? orderSum,
    Value<double?> paidSum = const Value.absent(),
    Value<double?> paymentSum = const Value.absent(),
    bool? physical,
  }) => Debt(
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
    paidSum: paidSum.present ? paidSum.value : this.paidSum,
    paymentSum: paymentSum.present ? paymentSum.value : this.paymentSum,
    physical: physical ?? this.physical,
  );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      ndoc: data.ndoc.present ? data.ndoc.value : this.ndoc,
      orderNdoc: data.orderNdoc.present ? data.orderNdoc.value : this.orderNdoc,
      ddate: data.ddate.present ? data.ddate.value : this.ddate,
      orderDdate:
          data.orderDdate.present ? data.orderDdate.value : this.orderDdate,
      isCheck: data.isCheck.present ? data.isCheck.value : this.isCheck,
      debtSum: data.debtSum.present ? data.debtSum.value : this.debtSum,
      orderSum: data.orderSum.present ? data.orderSum.value : this.orderSum,
      paidSum: data.paidSum.present ? data.paidSum.value : this.paidSum,
      paymentSum:
          data.paymentSum.present ? data.paymentSum.value : this.paymentSum,
      physical: data.physical.present ? data.physical.value : this.physical,
    );
  }

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
  int get hashCode => Object.hash(
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
    physical,
  );
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
  }) : buyerId = Value(buyerId),
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
    Expression<double>? paidSum,
    Expression<double>? paymentSum,
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

  DebtsCompanion copyWith({
    Value<int>? id,
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
    Value<bool>? physical,
  }) {
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
      map['paid_sum'] = Variable<double>(paidSum.value);
    }
    if (paymentSum.present) {
      map['payment_sum'] = Variable<double>(paymentSum.value);
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

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryIdMeta = const VerificationMeta(
    'deliveryId',
  );
  @override
  late final GeneratedColumn<int> deliveryId = GeneratedColumn<int>(
    'delivery_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordMeta = const VerificationMeta('ord');
  @override
  late final GeneratedColumn<int> ord = GeneratedColumn<int>(
    'ord',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ndocMeta = const VerificationMeta('ndoc');
  @override
  late final GeneratedColumn<String> ndoc = GeneratedColumn<String>(
    'ndoc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String> info = GeneratedColumn<String>(
    'info',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIncMeta = const VerificationMeta('isInc');
  @override
  late final GeneratedColumn<bool> isInc = GeneratedColumn<bool>(
    'is_inc',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_inc" IN (0, 1))',
    ),
  );
  static const VerificationMeta _goodsCntMeta = const VerificationMeta(
    'goodsCnt',
  );
  @override
  late final GeneratedColumn<int> goodsCnt = GeneratedColumn<int>(
    'goods_cnt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mcMeta = const VerificationMeta('mc');
  @override
  late final GeneratedColumn<double> mc = GeneratedColumn<double>(
    'mc',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveredMeta = const VerificationMeta(
    'delivered',
  );
  @override
  late final GeneratedColumn<bool> delivered = GeneratedColumn<bool>(
    'delivered',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delivered" IN (0, 1))',
    ),
  );
  static const VerificationMeta _paidMeta = const VerificationMeta('paid');
  @override
  late final GeneratedColumn<bool> paid = GeneratedColumn<bool>(
    'paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paid" IN (0, 1))',
    ),
  );
  static const VerificationMeta _physicalMeta = const VerificationMeta(
    'physical',
  );
  @override
  late final GeneratedColumn<bool> physical = GeneratedColumn<bool>(
    'physical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("physical" IN (0, 1))',
    ),
  );
  static const VerificationMeta _needScanMeta = const VerificationMeta(
    'needScan',
  );
  @override
  late final GeneratedColumn<bool> needScan = GeneratedColumn<bool>(
    'need_scan',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("need_scan" IN (0, 1))',
    ),
  );
  static const VerificationMeta _dovUnloadMeta = const VerificationMeta(
    'dovUnload',
  );
  @override
  late final GeneratedColumn<bool> dovUnload = GeneratedColumn<bool>(
    'dov_unload',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dov_unload" IN (0, 1))',
    ),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buyerId,
    deliveryId,
    ord,
    ndoc,
    info,
    isInc,
    goodsCnt,
    mc,
    delivered,
    paid,
    physical,
    needScan,
    dovUnload,
    address,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('delivery_id')) {
      context.handle(
        _deliveryIdMeta,
        deliveryId.isAcceptableOrUnknown(data['delivery_id']!, _deliveryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deliveryIdMeta);
    }
    if (data.containsKey('ord')) {
      context.handle(
        _ordMeta,
        ord.isAcceptableOrUnknown(data['ord']!, _ordMeta),
      );
    } else if (isInserting) {
      context.missing(_ordMeta);
    }
    if (data.containsKey('ndoc')) {
      context.handle(
        _ndocMeta,
        ndoc.isAcceptableOrUnknown(data['ndoc']!, _ndocMeta),
      );
    } else if (isInserting) {
      context.missing(_ndocMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
        _infoMeta,
        info.isAcceptableOrUnknown(data['info']!, _infoMeta),
      );
    } else if (isInserting) {
      context.missing(_infoMeta);
    }
    if (data.containsKey('is_inc')) {
      context.handle(
        _isIncMeta,
        isInc.isAcceptableOrUnknown(data['is_inc']!, _isIncMeta),
      );
    } else if (isInserting) {
      context.missing(_isIncMeta);
    }
    if (data.containsKey('goods_cnt')) {
      context.handle(
        _goodsCntMeta,
        goodsCnt.isAcceptableOrUnknown(data['goods_cnt']!, _goodsCntMeta),
      );
    } else if (isInserting) {
      context.missing(_goodsCntMeta);
    }
    if (data.containsKey('mc')) {
      context.handle(_mcMeta, mc.isAcceptableOrUnknown(data['mc']!, _mcMeta));
    } else if (isInserting) {
      context.missing(_mcMeta);
    }
    if (data.containsKey('delivered')) {
      context.handle(
        _deliveredMeta,
        delivered.isAcceptableOrUnknown(data['delivered']!, _deliveredMeta),
      );
    }
    if (data.containsKey('paid')) {
      context.handle(
        _paidMeta,
        paid.isAcceptableOrUnknown(data['paid']!, _paidMeta),
      );
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('physical')) {
      context.handle(
        _physicalMeta,
        physical.isAcceptableOrUnknown(data['physical']!, _physicalMeta),
      );
    } else if (isInserting) {
      context.missing(_physicalMeta);
    }
    if (data.containsKey('need_scan')) {
      context.handle(
        _needScanMeta,
        needScan.isAcceptableOrUnknown(data['need_scan']!, _needScanMeta),
      );
    } else if (isInserting) {
      context.missing(_needScanMeta);
    }
    if (data.containsKey('dov_unload')) {
      context.handle(
        _dovUnloadMeta,
        dovUnload.isAcceptableOrUnknown(data['dov_unload']!, _dovUnloadMeta),
      );
    } else if (isInserting) {
      context.missing(_dovUnloadMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      deliveryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}delivery_id'],
          )!,
      ord:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ord'],
          )!,
      ndoc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ndoc'],
          )!,
      info:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}info'],
          )!,
      isInc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_inc'],
          )!,
      goodsCnt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}goods_cnt'],
          )!,
      mc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}mc'],
          )!,
      delivered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delivered'],
      ),
      paid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}paid'],
          )!,
      physical:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}physical'],
          )!,
      needScan:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}need_scan'],
          )!,
      dovUnload:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}dov_unload'],
          )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int buyerId;
  final int deliveryId;
  final int ord;
  final String ndoc;
  final String info;
  final bool isInc;
  final int goodsCnt;
  final double mc;
  final bool? delivered;
  final bool paid;
  final bool physical;
  final bool needScan;
  final bool dovUnload;
  final String? address;
  const Order({
    required this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.ord,
    required this.ndoc,
    required this.info,
    required this.isInc,
    required this.goodsCnt,
    required this.mc,
    this.delivered,
    required this.paid,
    required this.physical,
    required this.needScan,
    required this.dovUnload,
    this.address,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['delivery_id'] = Variable<int>(deliveryId);
    map['ord'] = Variable<int>(ord);
    map['ndoc'] = Variable<String>(ndoc);
    map['info'] = Variable<String>(info);
    map['is_inc'] = Variable<bool>(isInc);
    map['goods_cnt'] = Variable<int>(goodsCnt);
    map['mc'] = Variable<double>(mc);
    if (!nullToAbsent || delivered != null) {
      map['delivered'] = Variable<bool>(delivered);
    }
    map['paid'] = Variable<bool>(paid);
    map['physical'] = Variable<bool>(physical);
    map['need_scan'] = Variable<bool>(needScan);
    map['dov_unload'] = Variable<bool>(dovUnload);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      deliveryId: Value(deliveryId),
      ord: Value(ord),
      ndoc: Value(ndoc),
      info: Value(info),
      isInc: Value(isInc),
      goodsCnt: Value(goodsCnt),
      mc: Value(mc),
      delivered:
          delivered == null && nullToAbsent
              ? const Value.absent()
              : Value(delivered),
      paid: Value(paid),
      physical: Value(physical),
      needScan: Value(needScan),
      dovUnload: Value(dovUnload),
      address:
          address == null && nullToAbsent
              ? const Value.absent()
              : Value(address),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      deliveryId: serializer.fromJson<int>(json['deliveryId']),
      ord: serializer.fromJson<int>(json['ord']),
      ndoc: serializer.fromJson<String>(json['ndoc']),
      info: serializer.fromJson<String>(json['info']),
      isInc: serializer.fromJson<bool>(json['isInc']),
      goodsCnt: serializer.fromJson<int>(json['goodsCnt']),
      mc: serializer.fromJson<double>(json['mc']),
      delivered: serializer.fromJson<bool?>(json['delivered']),
      paid: serializer.fromJson<bool>(json['paid']),
      physical: serializer.fromJson<bool>(json['physical']),
      needScan: serializer.fromJson<bool>(json['needScan']),
      dovUnload: serializer.fromJson<bool>(json['dovUnload']),
      address: serializer.fromJson<String?>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'deliveryId': serializer.toJson<int>(deliveryId),
      'ord': serializer.toJson<int>(ord),
      'ndoc': serializer.toJson<String>(ndoc),
      'info': serializer.toJson<String>(info),
      'isInc': serializer.toJson<bool>(isInc),
      'goodsCnt': serializer.toJson<int>(goodsCnt),
      'mc': serializer.toJson<double>(mc),
      'delivered': serializer.toJson<bool?>(delivered),
      'paid': serializer.toJson<bool>(paid),
      'physical': serializer.toJson<bool>(physical),
      'needScan': serializer.toJson<bool>(needScan),
      'dovUnload': serializer.toJson<bool>(dovUnload),
      'address': serializer.toJson<String?>(address),
    };
  }

  Order copyWith({
    int? id,
    int? buyerId,
    int? deliveryId,
    int? ord,
    String? ndoc,
    String? info,
    bool? isInc,
    int? goodsCnt,
    double? mc,
    Value<bool?> delivered = const Value.absent(),
    bool? paid,
    bool? physical,
    bool? needScan,
    bool? dovUnload,
    Value<String?> address = const Value.absent(),
  }) => Order(
    id: id ?? this.id,
    buyerId: buyerId ?? this.buyerId,
    deliveryId: deliveryId ?? this.deliveryId,
    ord: ord ?? this.ord,
    ndoc: ndoc ?? this.ndoc,
    info: info ?? this.info,
    isInc: isInc ?? this.isInc,
    goodsCnt: goodsCnt ?? this.goodsCnt,
    mc: mc ?? this.mc,
    delivered: delivered.present ? delivered.value : this.delivered,
    paid: paid ?? this.paid,
    physical: physical ?? this.physical,
    needScan: needScan ?? this.needScan,
    dovUnload: dovUnload ?? this.dovUnload,
    address: address.present ? address.value : this.address,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      deliveryId:
          data.deliveryId.present ? data.deliveryId.value : this.deliveryId,
      ord: data.ord.present ? data.ord.value : this.ord,
      ndoc: data.ndoc.present ? data.ndoc.value : this.ndoc,
      info: data.info.present ? data.info.value : this.info,
      isInc: data.isInc.present ? data.isInc.value : this.isInc,
      goodsCnt: data.goodsCnt.present ? data.goodsCnt.value : this.goodsCnt,
      mc: data.mc.present ? data.mc.value : this.mc,
      delivered: data.delivered.present ? data.delivered.value : this.delivered,
      paid: data.paid.present ? data.paid.value : this.paid,
      physical: data.physical.present ? data.physical.value : this.physical,
      needScan: data.needScan.present ? data.needScan.value : this.needScan,
      dovUnload: data.dovUnload.present ? data.dovUnload.value : this.dovUnload,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('ord: $ord, ')
          ..write('ndoc: $ndoc, ')
          ..write('info: $info, ')
          ..write('isInc: $isInc, ')
          ..write('goodsCnt: $goodsCnt, ')
          ..write('mc: $mc, ')
          ..write('delivered: $delivered, ')
          ..write('paid: $paid, ')
          ..write('physical: $physical, ')
          ..write('needScan: $needScan, ')
          ..write('dovUnload: $dovUnload, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    buyerId,
    deliveryId,
    ord,
    ndoc,
    info,
    isInc,
    goodsCnt,
    mc,
    delivered,
    paid,
    physical,
    needScan,
    dovUnload,
    address,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.deliveryId == this.deliveryId &&
          other.ord == this.ord &&
          other.ndoc == this.ndoc &&
          other.info == this.info &&
          other.isInc == this.isInc &&
          other.goodsCnt == this.goodsCnt &&
          other.mc == this.mc &&
          other.delivered == this.delivered &&
          other.paid == this.paid &&
          other.physical == this.physical &&
          other.needScan == this.needScan &&
          other.dovUnload == this.dovUnload &&
          other.address == this.address);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> deliveryId;
  final Value<int> ord;
  final Value<String> ndoc;
  final Value<String> info;
  final Value<bool> isInc;
  final Value<int> goodsCnt;
  final Value<double> mc;
  final Value<bool?> delivered;
  final Value<bool> paid;
  final Value<bool> physical;
  final Value<bool> needScan;
  final Value<bool> dovUnload;
  final Value<String?> address;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.deliveryId = const Value.absent(),
    this.ord = const Value.absent(),
    this.ndoc = const Value.absent(),
    this.info = const Value.absent(),
    this.isInc = const Value.absent(),
    this.goodsCnt = const Value.absent(),
    this.mc = const Value.absent(),
    this.delivered = const Value.absent(),
    this.paid = const Value.absent(),
    this.physical = const Value.absent(),
    this.needScan = const Value.absent(),
    this.dovUnload = const Value.absent(),
    this.address = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int deliveryId,
    required int ord,
    required String ndoc,
    required String info,
    required bool isInc,
    required int goodsCnt,
    required double mc,
    this.delivered = const Value.absent(),
    required bool paid,
    required bool physical,
    required bool needScan,
    required bool dovUnload,
    this.address = const Value.absent(),
  }) : buyerId = Value(buyerId),
       deliveryId = Value(deliveryId),
       ord = Value(ord),
       ndoc = Value(ndoc),
       info = Value(info),
       isInc = Value(isInc),
       goodsCnt = Value(goodsCnt),
       mc = Value(mc),
       paid = Value(paid),
       physical = Value(physical),
       needScan = Value(needScan),
       dovUnload = Value(dovUnload);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? deliveryId,
    Expression<int>? ord,
    Expression<String>? ndoc,
    Expression<String>? info,
    Expression<bool>? isInc,
    Expression<int>? goodsCnt,
    Expression<double>? mc,
    Expression<bool>? delivered,
    Expression<bool>? paid,
    Expression<bool>? physical,
    Expression<bool>? needScan,
    Expression<bool>? dovUnload,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (ord != null) 'ord': ord,
      if (ndoc != null) 'ndoc': ndoc,
      if (info != null) 'info': info,
      if (isInc != null) 'is_inc': isInc,
      if (goodsCnt != null) 'goods_cnt': goodsCnt,
      if (mc != null) 'mc': mc,
      if (delivered != null) 'delivered': delivered,
      if (paid != null) 'paid': paid,
      if (physical != null) 'physical': physical,
      if (needScan != null) 'need_scan': needScan,
      if (dovUnload != null) 'dov_unload': dovUnload,
      if (address != null) 'address': address,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? buyerId,
    Value<int>? deliveryId,
    Value<int>? ord,
    Value<String>? ndoc,
    Value<String>? info,
    Value<bool>? isInc,
    Value<int>? goodsCnt,
    Value<double>? mc,
    Value<bool?>? delivered,
    Value<bool>? paid,
    Value<bool>? physical,
    Value<bool>? needScan,
    Value<bool>? dovUnload,
    Value<String?>? address,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      deliveryId: deliveryId ?? this.deliveryId,
      ord: ord ?? this.ord,
      ndoc: ndoc ?? this.ndoc,
      info: info ?? this.info,
      isInc: isInc ?? this.isInc,
      goodsCnt: goodsCnt ?? this.goodsCnt,
      mc: mc ?? this.mc,
      delivered: delivered ?? this.delivered,
      paid: paid ?? this.paid,
      physical: physical ?? this.physical,
      needScan: needScan ?? this.needScan,
      dovUnload: dovUnload ?? this.dovUnload,
      address: address ?? this.address,
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
    if (deliveryId.present) {
      map['delivery_id'] = Variable<int>(deliveryId.value);
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
      map['delivered'] = Variable<bool>(delivered.value);
    }
    if (paid.present) {
      map['paid'] = Variable<bool>(paid.value);
    }
    if (physical.present) {
      map['physical'] = Variable<bool>(physical.value);
    }
    if (needScan.present) {
      map['need_scan'] = Variable<bool>(needScan.value);
    }
    if (dovUnload.present) {
      map['dov_unload'] = Variable<bool>(dovUnload.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('ord: $ord, ')
          ..write('ndoc: $ndoc, ')
          ..write('info: $info, ')
          ..write('isInc: $isInc, ')
          ..write('goodsCnt: $goodsCnt, ')
          ..write('mc: $mc, ')
          ..write('delivered: $delivered, ')
          ..write('paid: $paid, ')
          ..write('physical: $physical, ')
          ..write('needScan: $needScan, ')
          ..write('dovUnload: $dovUnload, ')
          ..write('address: $address')
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
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int> subid = GeneratedColumn<int>(
    'subid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gtinMeta = const VerificationMeta('gtin');
  @override
  late final GeneratedColumn<String> gtin = GeneratedColumn<String>(
    'gtin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volMeta = const VerificationMeta('vol');
  @override
  late final GeneratedColumn<double> vol = GeneratedColumn<double>(
    'vol',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveredVolMeta = const VerificationMeta(
    'deliveredVol',
  );
  @override
  late final GeneratedColumn<double> deliveredVol = GeneratedColumn<double>(
    'delivered_vol',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _needMarkingMeta = const VerificationMeta(
    'needMarking',
  );
  @override
  late final GeneratedColumn<bool> needMarking = GeneratedColumn<bool>(
    'need_marking',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("need_marking" IN (0, 1))',
    ),
  );
  static const VerificationMeta _minMeasureIdMeta = const VerificationMeta(
    'minMeasureId',
  );
  @override
  late final GeneratedColumn<int> minMeasureId = GeneratedColumn<int>(
    'min_measure_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<OrderLineBarcode>, String>
  barcodeRels = GeneratedColumn<String>(
    'barcode_rels',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<OrderLineBarcode>>(
    $OrderLinesTable.$converterbarcodeRels,
  );
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
    minMeasureId,
    barcodeRels,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
        _subidMeta,
        subid.isAcceptableOrUnknown(data['subid']!, _subidMeta),
      );
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gtin')) {
      context.handle(
        _gtinMeta,
        gtin.isAcceptableOrUnknown(data['gtin']!, _gtinMeta),
      );
    } else if (isInserting) {
      context.missing(_gtinMeta);
    }
    if (data.containsKey('vol')) {
      context.handle(
        _volMeta,
        vol.isAcceptableOrUnknown(data['vol']!, _volMeta),
      );
    } else if (isInserting) {
      context.missing(_volMeta);
    }
    if (data.containsKey('delivered_vol')) {
      context.handle(
        _deliveredVolMeta,
        deliveredVol.isAcceptableOrUnknown(
          data['delivered_vol']!,
          _deliveredVolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveredVolMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('need_marking')) {
      context.handle(
        _needMarkingMeta,
        needMarking.isAcceptableOrUnknown(
          data['need_marking']!,
          _needMarkingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needMarkingMeta);
    }
    if (data.containsKey('min_measure_id')) {
      context.handle(
        _minMeasureIdMeta,
        minMeasureId.isAcceptableOrUnknown(
          data['min_measure_id']!,
          _minMeasureIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minMeasureIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid};
  @override
  OrderLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLine(
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      subid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}subid'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      gtin:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}gtin'],
          )!,
      vol:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}vol'],
          )!,
      deliveredVol:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}delivered_vol'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price'],
          )!,
      needMarking:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}need_marking'],
          )!,
      minMeasureId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}min_measure_id'],
          )!,
      barcodeRels: $OrderLinesTable.$converterbarcodeRels.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}barcode_rels'],
        )!,
      ),
    );
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<OrderLineBarcode>, String> $converterbarcodeRels =
      const OrderLineBarcodeListConverter();
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
  final int minMeasureId;
  final List<OrderLineBarcode> barcodeRels;
  const OrderLine({
    required this.orderId,
    required this.subid,
    required this.name,
    required this.gtin,
    required this.vol,
    required this.deliveredVol,
    required this.price,
    required this.needMarking,
    required this.minMeasureId,
    required this.barcodeRels,
  });
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
    map['min_measure_id'] = Variable<int>(minMeasureId);
    {
      map['barcode_rels'] = Variable<String>(
        $OrderLinesTable.$converterbarcodeRels.toSql(barcodeRels),
      );
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
      minMeasureId: Value(minMeasureId),
      barcodeRels: Value(barcodeRels),
    );
  }

  factory OrderLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
      minMeasureId: serializer.fromJson<int>(json['minMeasureId']),
      barcodeRels: serializer.fromJson<List<OrderLineBarcode>>(
        json['barcodeRels'],
      ),
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
      'minMeasureId': serializer.toJson<int>(minMeasureId),
      'barcodeRels': serializer.toJson<List<OrderLineBarcode>>(barcodeRels),
    };
  }

  OrderLine copyWith({
    int? orderId,
    int? subid,
    String? name,
    String? gtin,
    double? vol,
    double? deliveredVol,
    double? price,
    bool? needMarking,
    int? minMeasureId,
    List<OrderLineBarcode>? barcodeRels,
  }) => OrderLine(
    orderId: orderId ?? this.orderId,
    subid: subid ?? this.subid,
    name: name ?? this.name,
    gtin: gtin ?? this.gtin,
    vol: vol ?? this.vol,
    deliveredVol: deliveredVol ?? this.deliveredVol,
    price: price ?? this.price,
    needMarking: needMarking ?? this.needMarking,
    minMeasureId: minMeasureId ?? this.minMeasureId,
    barcodeRels: barcodeRels ?? this.barcodeRels,
  );
  OrderLine copyWithCompanion(OrderLinesCompanion data) {
    return OrderLine(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subid: data.subid.present ? data.subid.value : this.subid,
      name: data.name.present ? data.name.value : this.name,
      gtin: data.gtin.present ? data.gtin.value : this.gtin,
      vol: data.vol.present ? data.vol.value : this.vol,
      deliveredVol:
          data.deliveredVol.present
              ? data.deliveredVol.value
              : this.deliveredVol,
      price: data.price.present ? data.price.value : this.price,
      needMarking:
          data.needMarking.present ? data.needMarking.value : this.needMarking,
      minMeasureId:
          data.minMeasureId.present
              ? data.minMeasureId.value
              : this.minMeasureId,
      barcodeRels:
          data.barcodeRels.present ? data.barcodeRels.value : this.barcodeRels,
    );
  }

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
          ..write('minMeasureId: $minMeasureId, ')
          ..write('barcodeRels: $barcodeRels')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    orderId,
    subid,
    name,
    gtin,
    vol,
    deliveredVol,
    price,
    needMarking,
    minMeasureId,
    barcodeRels,
  );
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
          other.minMeasureId == this.minMeasureId &&
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
  final Value<int> minMeasureId;
  final Value<List<OrderLineBarcode>> barcodeRels;
  final Value<int> rowid;
  const OrderLinesCompanion({
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.name = const Value.absent(),
    this.gtin = const Value.absent(),
    this.vol = const Value.absent(),
    this.deliveredVol = const Value.absent(),
    this.price = const Value.absent(),
    this.needMarking = const Value.absent(),
    this.minMeasureId = const Value.absent(),
    this.barcodeRels = const Value.absent(),
    this.rowid = const Value.absent(),
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
    required int minMeasureId,
    required List<OrderLineBarcode> barcodeRels,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       subid = Value(subid),
       name = Value(name),
       gtin = Value(gtin),
       vol = Value(vol),
       deliveredVol = Value(deliveredVol),
       price = Value(price),
       needMarking = Value(needMarking),
       minMeasureId = Value(minMeasureId),
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
    Expression<int>? minMeasureId,
    Expression<String>? barcodeRels,
    Expression<int>? rowid,
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
      if (minMeasureId != null) 'min_measure_id': minMeasureId,
      if (barcodeRels != null) 'barcode_rels': barcodeRels,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLinesCompanion copyWith({
    Value<int>? orderId,
    Value<int>? subid,
    Value<String>? name,
    Value<String>? gtin,
    Value<double>? vol,
    Value<double>? deliveredVol,
    Value<double>? price,
    Value<bool>? needMarking,
    Value<int>? minMeasureId,
    Value<List<OrderLineBarcode>>? barcodeRels,
    Value<int>? rowid,
  }) {
    return OrderLinesCompanion(
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      name: name ?? this.name,
      gtin: gtin ?? this.gtin,
      vol: vol ?? this.vol,
      deliveredVol: deliveredVol ?? this.deliveredVol,
      price: price ?? this.price,
      needMarking: needMarking ?? this.needMarking,
      minMeasureId: minMeasureId ?? this.minMeasureId,
      barcodeRels: barcodeRels ?? this.barcodeRels,
      rowid: rowid ?? this.rowid,
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
    if (minMeasureId.present) {
      map['min_measure_id'] = Variable<int>(minMeasureId.value);
    }
    if (barcodeRels.present) {
      map['barcode_rels'] = Variable<String>(
        $OrderLinesTable.$converterbarcodeRels.toSql(barcodeRels.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('minMeasureId: $minMeasureId, ')
          ..write('barcodeRels: $barcodeRels, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int> subid = GeneratedColumn<int>(
    'subid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDataMatrixMeta = const VerificationMeta(
    'isDataMatrix',
  );
  @override
  late final GeneratedColumn<bool> isDataMatrix = GeneratedColumn<bool>(
    'is_data_matrix',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_data_matrix" IN (0, 1))',
    ),
  );
  static const VerificationMeta _groupCodeMeta = const VerificationMeta(
    'groupCode',
  );
  @override
  late final GeneratedColumn<String> groupCode = GeneratedColumn<String>(
    'group_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localTsMeta = const VerificationMeta(
    'localTs',
  );
  @override
  late final GeneratedColumn<DateTime> localTs = GeneratedColumn<DateTime>(
    'local_ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    subid,
    code,
    amount,
    isDataMatrix,
    groupCode,
    localTs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_line_codes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderLineCode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
        _subidMeta,
        subid.isAcceptableOrUnknown(data['subid']!, _subidMeta),
      );
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_data_matrix')) {
      context.handle(
        _isDataMatrixMeta,
        isDataMatrix.isAcceptableOrUnknown(
          data['is_data_matrix']!,
          _isDataMatrixMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isDataMatrixMeta);
    }
    if (data.containsKey('group_code')) {
      context.handle(
        _groupCodeMeta,
        groupCode.isAcceptableOrUnknown(data['group_code']!, _groupCodeMeta),
      );
    }
    if (data.containsKey('local_ts')) {
      context.handle(
        _localTsMeta,
        localTs.isAcceptableOrUnknown(data['local_ts']!, _localTsMeta),
      );
    } else if (isInserting) {
      context.missing(_localTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid, code};
  @override
  OrderLineCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLineCode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      subid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}subid'],
          )!,
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}amount'],
          )!,
      isDataMatrix:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_data_matrix'],
          )!,
      groupCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_code'],
      ),
      localTs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}local_ts'],
          )!,
    );
  }

  @override
  $OrderLineCodesTable createAlias(String alias) {
    return $OrderLineCodesTable(attachedDatabase, alias);
  }
}

class OrderLineCode extends DataClass implements Insertable<OrderLineCode> {
  final int? id;
  final int orderId;
  final int subid;
  final String code;
  final int amount;
  final bool isDataMatrix;
  final String? groupCode;
  final DateTime localTs;
  const OrderLineCode({
    this.id,
    required this.orderId,
    required this.subid,
    required this.code,
    required this.amount,
    required this.isDataMatrix,
    this.groupCode,
    required this.localTs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['order_id'] = Variable<int>(orderId);
    map['subid'] = Variable<int>(subid);
    map['code'] = Variable<String>(code);
    map['amount'] = Variable<int>(amount);
    map['is_data_matrix'] = Variable<bool>(isDataMatrix);
    if (!nullToAbsent || groupCode != null) {
      map['group_code'] = Variable<String>(groupCode);
    }
    map['local_ts'] = Variable<DateTime>(localTs);
    return map;
  }

  OrderLineCodesCompanion toCompanion(bool nullToAbsent) {
    return OrderLineCodesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      orderId: Value(orderId),
      subid: Value(subid),
      code: Value(code),
      amount: Value(amount),
      isDataMatrix: Value(isDataMatrix),
      groupCode:
          groupCode == null && nullToAbsent
              ? const Value.absent()
              : Value(groupCode),
      localTs: Value(localTs),
    );
  }

  factory OrderLineCode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLineCode(
      id: serializer.fromJson<int?>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      subid: serializer.fromJson<int>(json['subid']),
      code: serializer.fromJson<String>(json['code']),
      amount: serializer.fromJson<int>(json['amount']),
      isDataMatrix: serializer.fromJson<bool>(json['isDataMatrix']),
      groupCode: serializer.fromJson<String?>(json['groupCode']),
      localTs: serializer.fromJson<DateTime>(json['localTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'orderId': serializer.toJson<int>(orderId),
      'subid': serializer.toJson<int>(subid),
      'code': serializer.toJson<String>(code),
      'amount': serializer.toJson<int>(amount),
      'isDataMatrix': serializer.toJson<bool>(isDataMatrix),
      'groupCode': serializer.toJson<String?>(groupCode),
      'localTs': serializer.toJson<DateTime>(localTs),
    };
  }

  OrderLineCode copyWith({
    Value<int?> id = const Value.absent(),
    int? orderId,
    int? subid,
    String? code,
    int? amount,
    bool? isDataMatrix,
    Value<String?> groupCode = const Value.absent(),
    DateTime? localTs,
  }) => OrderLineCode(
    id: id.present ? id.value : this.id,
    orderId: orderId ?? this.orderId,
    subid: subid ?? this.subid,
    code: code ?? this.code,
    amount: amount ?? this.amount,
    isDataMatrix: isDataMatrix ?? this.isDataMatrix,
    groupCode: groupCode.present ? groupCode.value : this.groupCode,
    localTs: localTs ?? this.localTs,
  );
  OrderLineCode copyWithCompanion(OrderLineCodesCompanion data) {
    return OrderLineCode(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subid: data.subid.present ? data.subid.value : this.subid,
      code: data.code.present ? data.code.value : this.code,
      amount: data.amount.present ? data.amount.value : this.amount,
      isDataMatrix:
          data.isDataMatrix.present
              ? data.isDataMatrix.value
              : this.isDataMatrix,
      groupCode: data.groupCode.present ? data.groupCode.value : this.groupCode,
      localTs: data.localTs.present ? data.localTs.value : this.localTs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineCode(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('amount: $amount, ')
          ..write('isDataMatrix: $isDataMatrix, ')
          ..write('groupCode: $groupCode, ')
          ..write('localTs: $localTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    subid,
    code,
    amount,
    isDataMatrix,
    groupCode,
    localTs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLineCode &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.subid == this.subid &&
          other.code == this.code &&
          other.amount == this.amount &&
          other.isDataMatrix == this.isDataMatrix &&
          other.groupCode == this.groupCode &&
          other.localTs == this.localTs);
}

class OrderLineCodesCompanion extends UpdateCompanion<OrderLineCode> {
  final Value<int?> id;
  final Value<int> orderId;
  final Value<int> subid;
  final Value<String> code;
  final Value<int> amount;
  final Value<bool> isDataMatrix;
  final Value<String?> groupCode;
  final Value<DateTime> localTs;
  final Value<int> rowid;
  const OrderLineCodesCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.code = const Value.absent(),
    this.amount = const Value.absent(),
    this.isDataMatrix = const Value.absent(),
    this.groupCode = const Value.absent(),
    this.localTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLineCodesCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int subid,
    required String code,
    required int amount,
    required bool isDataMatrix,
    this.groupCode = const Value.absent(),
    required DateTime localTs,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       subid = Value(subid),
       code = Value(code),
       amount = Value(amount),
       isDataMatrix = Value(isDataMatrix),
       localTs = Value(localTs);
  static Insertable<OrderLineCode> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? subid,
    Expression<String>? code,
    Expression<int>? amount,
    Expression<bool>? isDataMatrix,
    Expression<String>? groupCode,
    Expression<DateTime>? localTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (code != null) 'code': code,
      if (amount != null) 'amount': amount,
      if (isDataMatrix != null) 'is_data_matrix': isDataMatrix,
      if (groupCode != null) 'group_code': groupCode,
      if (localTs != null) 'local_ts': localTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLineCodesCompanion copyWith({
    Value<int?>? id,
    Value<int>? orderId,
    Value<int>? subid,
    Value<String>? code,
    Value<int>? amount,
    Value<bool>? isDataMatrix,
    Value<String?>? groupCode,
    Value<DateTime>? localTs,
    Value<int>? rowid,
  }) {
    return OrderLineCodesCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      code: code ?? this.code,
      amount: amount ?? this.amount,
      isDataMatrix: isDataMatrix ?? this.isDataMatrix,
      groupCode: groupCode ?? this.groupCode,
      localTs: localTs ?? this.localTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
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
    if (groupCode.present) {
      map['group_code'] = Variable<String>(groupCode.value);
    }
    if (localTs.present) {
      map['local_ts'] = Variable<DateTime>(localTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineCodesCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('amount: $amount, ')
          ..write('isDataMatrix: $isDataMatrix, ')
          ..write('groupCode: $groupCode, ')
          ..write('localTs: $localTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderLineStorageCodesTable extends OrderLineStorageCodes
    with TableInfo<$OrderLineStorageCodesTable, OrderLineStorageCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLineStorageCodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int> subid = GeneratedColumn<int>(
    'subid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupCodeMeta = const VerificationMeta(
    'groupCode',
  );
  @override
  late final GeneratedColumn<String> groupCode = GeneratedColumn<String>(
    'group_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    orderId,
    subid,
    code,
    groupCode,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_line_storage_codes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderLineStorageCode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
        _subidMeta,
        subid.isAcceptableOrUnknown(data['subid']!, _subidMeta),
      );
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('group_code')) {
      context.handle(
        _groupCodeMeta,
        groupCode.isAcceptableOrUnknown(data['group_code']!, _groupCodeMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid, code};
  @override
  OrderLineStorageCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLineStorageCode(
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      subid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}subid'],
          )!,
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      groupCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_code'],
      ),
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}amount'],
          )!,
    );
  }

  @override
  $OrderLineStorageCodesTable createAlias(String alias) {
    return $OrderLineStorageCodesTable(attachedDatabase, alias);
  }
}

class OrderLineStorageCode extends DataClass
    implements Insertable<OrderLineStorageCode> {
  final int orderId;
  final int subid;
  final String code;
  final String? groupCode;
  final int amount;
  const OrderLineStorageCode({
    required this.orderId,
    required this.subid,
    required this.code,
    this.groupCode,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['subid'] = Variable<int>(subid);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || groupCode != null) {
      map['group_code'] = Variable<String>(groupCode);
    }
    map['amount'] = Variable<int>(amount);
    return map;
  }

  OrderLineStorageCodesCompanion toCompanion(bool nullToAbsent) {
    return OrderLineStorageCodesCompanion(
      orderId: Value(orderId),
      subid: Value(subid),
      code: Value(code),
      groupCode:
          groupCode == null && nullToAbsent
              ? const Value.absent()
              : Value(groupCode),
      amount: Value(amount),
    );
  }

  factory OrderLineStorageCode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLineStorageCode(
      orderId: serializer.fromJson<int>(json['orderId']),
      subid: serializer.fromJson<int>(json['subid']),
      code: serializer.fromJson<String>(json['code']),
      groupCode: serializer.fromJson<String?>(json['groupCode']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'subid': serializer.toJson<int>(subid),
      'code': serializer.toJson<String>(code),
      'groupCode': serializer.toJson<String?>(groupCode),
      'amount': serializer.toJson<int>(amount),
    };
  }

  OrderLineStorageCode copyWith({
    int? orderId,
    int? subid,
    String? code,
    Value<String?> groupCode = const Value.absent(),
    int? amount,
  }) => OrderLineStorageCode(
    orderId: orderId ?? this.orderId,
    subid: subid ?? this.subid,
    code: code ?? this.code,
    groupCode: groupCode.present ? groupCode.value : this.groupCode,
    amount: amount ?? this.amount,
  );
  OrderLineStorageCode copyWithCompanion(OrderLineStorageCodesCompanion data) {
    return OrderLineStorageCode(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subid: data.subid.present ? data.subid.value : this.subid,
      code: data.code.present ? data.code.value : this.code,
      groupCode: data.groupCode.present ? data.groupCode.value : this.groupCode,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineStorageCode(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('groupCode: $groupCode, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(orderId, subid, code, groupCode, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLineStorageCode &&
          other.orderId == this.orderId &&
          other.subid == this.subid &&
          other.code == this.code &&
          other.groupCode == this.groupCode &&
          other.amount == this.amount);
}

class OrderLineStorageCodesCompanion
    extends UpdateCompanion<OrderLineStorageCode> {
  final Value<int> orderId;
  final Value<int> subid;
  final Value<String> code;
  final Value<String?> groupCode;
  final Value<int> amount;
  final Value<int> rowid;
  const OrderLineStorageCodesCompanion({
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.code = const Value.absent(),
    this.groupCode = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLineStorageCodesCompanion.insert({
    required int orderId,
    required int subid,
    required String code,
    this.groupCode = const Value.absent(),
    required int amount,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       subid = Value(subid),
       code = Value(code),
       amount = Value(amount);
  static Insertable<OrderLineStorageCode> custom({
    Expression<int>? orderId,
    Expression<int>? subid,
    Expression<String>? code,
    Expression<String>? groupCode,
    Expression<int>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (code != null) 'code': code,
      if (groupCode != null) 'group_code': groupCode,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLineStorageCodesCompanion copyWith({
    Value<int>? orderId,
    Value<int>? subid,
    Value<String>? code,
    Value<String?>? groupCode,
    Value<int>? amount,
    Value<int>? rowid,
  }) {
    return OrderLineStorageCodesCompanion(
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      code: code ?? this.code,
      groupCode: groupCode ?? this.groupCode,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
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
    if (groupCode.present) {
      map['group_code'] = Variable<String>(groupCode.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineStorageCodesCompanion(')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('groupCode: $groupCode, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderLinePackErrorsTable extends OrderLinePackErrors
    with TableInfo<$OrderLinePackErrorsTable, OrderLinePackError> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLinePackErrorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subidMeta = const VerificationMeta('subid');
  @override
  late final GeneratedColumn<int> subid = GeneratedColumn<int>(
    'subid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measureIdMeta = const VerificationMeta(
    'measureId',
  );
  @override
  late final GeneratedColumn<int> measureId = GeneratedColumn<int>(
    'measure_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
    'volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupCodeMeta = const VerificationMeta(
    'groupCode',
  );
  @override
  late final GeneratedColumn<String> groupCode = GeneratedColumn<String>(
    'group_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localTsMeta = const VerificationMeta(
    'localTs',
  );
  @override
  late final GeneratedColumn<DateTime> localTs = GeneratedColumn<DateTime>(
    'local_ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    subid,
    measureId,
    volume,
    groupCode,
    localTs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_line_pack_errors';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderLinePackError> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('subid')) {
      context.handle(
        _subidMeta,
        subid.isAcceptableOrUnknown(data['subid']!, _subidMeta),
      );
    } else if (isInserting) {
      context.missing(_subidMeta);
    }
    if (data.containsKey('measure_id')) {
      context.handle(
        _measureIdMeta,
        measureId.isAcceptableOrUnknown(data['measure_id']!, _measureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_measureIdMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(
        _volumeMeta,
        volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('group_code')) {
      context.handle(
        _groupCodeMeta,
        groupCode.isAcceptableOrUnknown(data['group_code']!, _groupCodeMeta),
      );
    }
    if (data.containsKey('local_ts')) {
      context.handle(
        _localTsMeta,
        localTs.isAcceptableOrUnknown(data['local_ts']!, _localTsMeta),
      );
    } else if (isInserting) {
      context.missing(_localTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, subid};
  @override
  OrderLinePackError map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLinePackError(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      orderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_id'],
          )!,
      subid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}subid'],
          )!,
      measureId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}measure_id'],
          )!,
      volume:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}volume'],
          )!,
      groupCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_code'],
      ),
      localTs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}local_ts'],
          )!,
    );
  }

  @override
  $OrderLinePackErrorsTable createAlias(String alias) {
    return $OrderLinePackErrorsTable(attachedDatabase, alias);
  }
}

class OrderLinePackError extends DataClass
    implements Insertable<OrderLinePackError> {
  final int? id;
  final int orderId;
  final int subid;
  final int measureId;
  final double volume;
  final String? groupCode;
  final DateTime localTs;
  const OrderLinePackError({
    this.id,
    required this.orderId,
    required this.subid,
    required this.measureId,
    required this.volume,
    this.groupCode,
    required this.localTs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['order_id'] = Variable<int>(orderId);
    map['subid'] = Variable<int>(subid);
    map['measure_id'] = Variable<int>(measureId);
    map['volume'] = Variable<double>(volume);
    if (!nullToAbsent || groupCode != null) {
      map['group_code'] = Variable<String>(groupCode);
    }
    map['local_ts'] = Variable<DateTime>(localTs);
    return map;
  }

  OrderLinePackErrorsCompanion toCompanion(bool nullToAbsent) {
    return OrderLinePackErrorsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      orderId: Value(orderId),
      subid: Value(subid),
      measureId: Value(measureId),
      volume: Value(volume),
      groupCode:
          groupCode == null && nullToAbsent
              ? const Value.absent()
              : Value(groupCode),
      localTs: Value(localTs),
    );
  }

  factory OrderLinePackError.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLinePackError(
      id: serializer.fromJson<int?>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      subid: serializer.fromJson<int>(json['subid']),
      measureId: serializer.fromJson<int>(json['measureId']),
      volume: serializer.fromJson<double>(json['volume']),
      groupCode: serializer.fromJson<String?>(json['groupCode']),
      localTs: serializer.fromJson<DateTime>(json['localTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'orderId': serializer.toJson<int>(orderId),
      'subid': serializer.toJson<int>(subid),
      'measureId': serializer.toJson<int>(measureId),
      'volume': serializer.toJson<double>(volume),
      'groupCode': serializer.toJson<String?>(groupCode),
      'localTs': serializer.toJson<DateTime>(localTs),
    };
  }

  OrderLinePackError copyWith({
    Value<int?> id = const Value.absent(),
    int? orderId,
    int? subid,
    int? measureId,
    double? volume,
    Value<String?> groupCode = const Value.absent(),
    DateTime? localTs,
  }) => OrderLinePackError(
    id: id.present ? id.value : this.id,
    orderId: orderId ?? this.orderId,
    subid: subid ?? this.subid,
    measureId: measureId ?? this.measureId,
    volume: volume ?? this.volume,
    groupCode: groupCode.present ? groupCode.value : this.groupCode,
    localTs: localTs ?? this.localTs,
  );
  OrderLinePackError copyWithCompanion(OrderLinePackErrorsCompanion data) {
    return OrderLinePackError(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subid: data.subid.present ? data.subid.value : this.subid,
      measureId: data.measureId.present ? data.measureId.value : this.measureId,
      volume: data.volume.present ? data.volume.value : this.volume,
      groupCode: data.groupCode.present ? data.groupCode.value : this.groupCode,
      localTs: data.localTs.present ? data.localTs.value : this.localTs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinePackError(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('measureId: $measureId, ')
          ..write('volume: $volume, ')
          ..write('groupCode: $groupCode, ')
          ..write('localTs: $localTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orderId, subid, measureId, volume, groupCode, localTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLinePackError &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.subid == this.subid &&
          other.measureId == this.measureId &&
          other.volume == this.volume &&
          other.groupCode == this.groupCode &&
          other.localTs == this.localTs);
}

class OrderLinePackErrorsCompanion extends UpdateCompanion<OrderLinePackError> {
  final Value<int?> id;
  final Value<int> orderId;
  final Value<int> subid;
  final Value<int> measureId;
  final Value<double> volume;
  final Value<String?> groupCode;
  final Value<DateTime> localTs;
  final Value<int> rowid;
  const OrderLinePackErrorsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.measureId = const Value.absent(),
    this.volume = const Value.absent(),
    this.groupCode = const Value.absent(),
    this.localTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLinePackErrorsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int subid,
    required int measureId,
    required double volume,
    this.groupCode = const Value.absent(),
    required DateTime localTs,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       subid = Value(subid),
       measureId = Value(measureId),
       volume = Value(volume),
       localTs = Value(localTs);
  static Insertable<OrderLinePackError> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? subid,
    Expression<int>? measureId,
    Expression<double>? volume,
    Expression<String>? groupCode,
    Expression<DateTime>? localTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (measureId != null) 'measure_id': measureId,
      if (volume != null) 'volume': volume,
      if (groupCode != null) 'group_code': groupCode,
      if (localTs != null) 'local_ts': localTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLinePackErrorsCompanion copyWith({
    Value<int?>? id,
    Value<int>? orderId,
    Value<int>? subid,
    Value<int>? measureId,
    Value<double>? volume,
    Value<String?>? groupCode,
    Value<DateTime>? localTs,
    Value<int>? rowid,
  }) {
    return OrderLinePackErrorsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      measureId: measureId ?? this.measureId,
      volume: volume ?? this.volume,
      groupCode: groupCode ?? this.groupCode,
      localTs: localTs ?? this.localTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (subid.present) {
      map['subid'] = Variable<int>(subid.value);
    }
    if (measureId.present) {
      map['measure_id'] = Variable<int>(measureId.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (groupCode.present) {
      map['group_code'] = Variable<String>(groupCode.value);
    }
    if (localTs.present) {
      map['local_ts'] = Variable<DateTime>(localTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinePackErrorsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('measureId: $measureId, ')
          ..write('volume: $volume, ')
          ..write('groupCode: $groupCode, ')
          ..write('localTs: $localTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BuyerDeliveryMarksTable extends BuyerDeliveryMarks
    with TableInfo<$BuyerDeliveryMarksTable, BuyerDeliveryMark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyerDeliveryMarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryIdMeta = const VerificationMeta(
    'deliveryId',
  );
  @override
  late final GeneratedColumn<int> deliveryId = GeneratedColumn<int>(
    'delivery_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BuyerDeliveryMarkType, String>
  type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<BuyerDeliveryMarkType>(
    $BuyerDeliveryMarksTable.$convertertype,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headingMeta = const VerificationMeta(
    'heading',
  );
  @override
  late final GeneratedColumn<double> heading = GeneratedColumn<double>(
    'heading',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointTsMeta = const VerificationMeta(
    'pointTs',
  );
  @override
  late final GeneratedColumn<DateTime> pointTs = GeneratedColumn<DateTime>(
    'point_ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buyerId,
    deliveryId,
    type,
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    pointTs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buyer_delivery_marks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BuyerDeliveryMark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('delivery_id')) {
      context.handle(
        _deliveryIdMeta,
        deliveryId.isAcceptableOrUnknown(data['delivery_id']!, _deliveryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deliveryIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_altitudeMeta);
    }
    if (data.containsKey('heading')) {
      context.handle(
        _headingMeta,
        heading.isAcceptableOrUnknown(data['heading']!, _headingMeta),
      );
    } else if (isInserting) {
      context.missing(_headingMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('point_ts')) {
      context.handle(
        _pointTsMeta,
        pointTs.isAcceptableOrUnknown(data['point_ts']!, _pointTsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {buyerId, deliveryId, type};
  @override
  BuyerDeliveryMark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuyerDeliveryMark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      deliveryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}delivery_id'],
          )!,
      type: $BuyerDeliveryMarksTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      latitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}latitude'],
          )!,
      longitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}longitude'],
          )!,
      accuracy:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}accuracy'],
          )!,
      altitude:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}altitude'],
          )!,
      heading:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}heading'],
          )!,
      speed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}speed'],
          )!,
      pointTs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}point_ts'],
          )!,
    );
  }

  @override
  $BuyerDeliveryMarksTable createAlias(String alias) {
    return $BuyerDeliveryMarksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BuyerDeliveryMarkType, String, String>
  $convertertype = const EnumNameConverter<BuyerDeliveryMarkType>(
    BuyerDeliveryMarkType.values,
  );
}

class BuyerDeliveryMark extends DataClass
    implements Insertable<BuyerDeliveryMark> {
  final int? id;
  final int buyerId;
  final int deliveryId;
  final BuyerDeliveryMarkType type;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  final DateTime pointTs;
  const BuyerDeliveryMark({
    this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.pointTs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['buyer_id'] = Variable<int>(buyerId);
    map['delivery_id'] = Variable<int>(deliveryId);
    {
      map['type'] = Variable<String>(
        $BuyerDeliveryMarksTable.$convertertype.toSql(type),
      );
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['accuracy'] = Variable<double>(accuracy);
    map['altitude'] = Variable<double>(altitude);
    map['heading'] = Variable<double>(heading);
    map['speed'] = Variable<double>(speed);
    map['point_ts'] = Variable<DateTime>(pointTs);
    return map;
  }

  BuyerDeliveryMarksCompanion toCompanion(bool nullToAbsent) {
    return BuyerDeliveryMarksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      buyerId: Value(buyerId),
      deliveryId: Value(deliveryId),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracy: Value(accuracy),
      altitude: Value(altitude),
      heading: Value(heading),
      speed: Value(speed),
      pointTs: Value(pointTs),
    );
  }

  factory BuyerDeliveryMark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuyerDeliveryMark(
      id: serializer.fromJson<int?>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      deliveryId: serializer.fromJson<int>(json['deliveryId']),
      type: $BuyerDeliveryMarksTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracy: serializer.fromJson<double>(json['accuracy']),
      altitude: serializer.fromJson<double>(json['altitude']),
      heading: serializer.fromJson<double>(json['heading']),
      speed: serializer.fromJson<double>(json['speed']),
      pointTs: serializer.fromJson<DateTime>(json['pointTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'deliveryId': serializer.toJson<int>(deliveryId),
      'type': serializer.toJson<String>(
        $BuyerDeliveryMarksTable.$convertertype.toJson(type),
      ),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracy': serializer.toJson<double>(accuracy),
      'altitude': serializer.toJson<double>(altitude),
      'heading': serializer.toJson<double>(heading),
      'speed': serializer.toJson<double>(speed),
      'pointTs': serializer.toJson<DateTime>(pointTs),
    };
  }

  BuyerDeliveryMark copyWith({
    Value<int?> id = const Value.absent(),
    int? buyerId,
    int? deliveryId,
    BuyerDeliveryMarkType? type,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? heading,
    double? speed,
    DateTime? pointTs,
  }) => BuyerDeliveryMark(
    id: id.present ? id.value : this.id,
    buyerId: buyerId ?? this.buyerId,
    deliveryId: deliveryId ?? this.deliveryId,
    type: type ?? this.type,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    accuracy: accuracy ?? this.accuracy,
    altitude: altitude ?? this.altitude,
    heading: heading ?? this.heading,
    speed: speed ?? this.speed,
    pointTs: pointTs ?? this.pointTs,
  );
  BuyerDeliveryMark copyWithCompanion(BuyerDeliveryMarksCompanion data) {
    return BuyerDeliveryMark(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      deliveryId:
          data.deliveryId.present ? data.deliveryId.value : this.deliveryId,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      heading: data.heading.present ? data.heading.value : this.heading,
      speed: data.speed.present ? data.speed.value : this.speed,
      pointTs: data.pointTs.present ? data.pointTs.value : this.pointTs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryMark(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('heading: $heading, ')
          ..write('speed: $speed, ')
          ..write('pointTs: $pointTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    buyerId,
    deliveryId,
    type,
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    pointTs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuyerDeliveryMark &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.deliveryId == this.deliveryId &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.altitude == this.altitude &&
          other.heading == this.heading &&
          other.speed == this.speed &&
          other.pointTs == this.pointTs);
}

class BuyerDeliveryMarksCompanion extends UpdateCompanion<BuyerDeliveryMark> {
  final Value<int?> id;
  final Value<int> buyerId;
  final Value<int> deliveryId;
  final Value<BuyerDeliveryMarkType> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> accuracy;
  final Value<double> altitude;
  final Value<double> heading;
  final Value<double> speed;
  final Value<DateTime> pointTs;
  final Value<int> rowid;
  const BuyerDeliveryMarksCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.deliveryId = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.heading = const Value.absent(),
    this.speed = const Value.absent(),
    this.pointTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BuyerDeliveryMarksCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int deliveryId,
    required BuyerDeliveryMarkType type,
    required double latitude,
    required double longitude,
    required double accuracy,
    required double altitude,
    required double heading,
    required double speed,
    required DateTime pointTs,
    this.rowid = const Value.absent(),
  }) : buyerId = Value(buyerId),
       deliveryId = Value(deliveryId),
       type = Value(type),
       latitude = Value(latitude),
       longitude = Value(longitude),
       accuracy = Value(accuracy),
       altitude = Value(altitude),
       heading = Value(heading),
       speed = Value(speed),
       pointTs = Value(pointTs);
  static Insertable<BuyerDeliveryMark> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? deliveryId,
    Expression<String>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<double>? altitude,
    Expression<double>? heading,
    Expression<double>? speed,
    Expression<DateTime>? pointTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      if (heading != null) 'heading': heading,
      if (speed != null) 'speed': speed,
      if (pointTs != null) 'point_ts': pointTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BuyerDeliveryMarksCompanion copyWith({
    Value<int?>? id,
    Value<int>? buyerId,
    Value<int>? deliveryId,
    Value<BuyerDeliveryMarkType>? type,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? accuracy,
    Value<double>? altitude,
    Value<double>? heading,
    Value<double>? speed,
    Value<DateTime>? pointTs,
    Value<int>? rowid,
  }) {
    return BuyerDeliveryMarksCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      deliveryId: deliveryId ?? this.deliveryId,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      pointTs: pointTs ?? this.pointTs,
      rowid: rowid ?? this.rowid,
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
    if (deliveryId.present) {
      map['delivery_id'] = Variable<int>(deliveryId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $BuyerDeliveryMarksTable.$convertertype.toSql(type.value),
      );
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (heading.present) {
      map['heading'] = Variable<double>(heading.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (pointTs.present) {
      map['point_ts'] = Variable<DateTime>(pointTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryMarksCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('heading: $heading, ')
          ..write('speed: $speed, ')
          ..write('pointTs: $pointTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BuyerDeliveryPointsTable extends BuyerDeliveryPoints
    with TableInfo<$BuyerDeliveryPointsTable, BuyerDeliveryPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyerDeliveryPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastSyncTimeMeta = const VerificationMeta(
    'lastSyncTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncTime = GeneratedColumn<DateTime>(
    'last_sync_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needSyncMeta = const VerificationMeta(
    'needSync',
  );
  @override
  late final GeneratedColumn<bool> needSync = GeneratedColumn<bool>(
    'need_sync',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      (isNew & BooleanExpressionOperators(isDeleted).not()) |
          (BooleanExpressionOperators(isNew).not() &
              ComparableExpr(lastSyncTime).isSmallerThan(timestamp)),
      true,
    ),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("need_sync" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    generatedAs: GeneratedAs(lastSyncTime.isNull(), false),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String> info = GeneratedColumn<String>(
    'info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    isDeleted,
    timestamp,
    lastSyncTime,
    needSync,
    isNew,
    id,
    buyerId,
    phone,
    info,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buyer_delivery_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<BuyerDeliveryPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
        _lastSyncTimeMeta,
        lastSyncTime.isAcceptableOrUnknown(
          data['last_sync_time']!,
          _lastSyncTimeMeta,
        ),
      );
    }
    if (data.containsKey('need_sync')) {
      context.handle(
        _needSyncMeta,
        needSync.isAcceptableOrUnknown(data['need_sync']!, _needSyncMeta),
      );
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('info')) {
      context.handle(
        _infoMeta,
        info.isAcceptableOrUnknown(data['info']!, _infoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuyerDeliveryPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuyerDeliveryPoint(
      isDeleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_deleted'],
          )!,
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
      lastSyncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_time'],
      ),
      needSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}need_sync'],
          )!,
      isNew:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_new'],
          )!,
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      info: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}info'],
      ),
    );
  }

  @override
  $BuyerDeliveryPointsTable createAlias(String alias) {
    return $BuyerDeliveryPointsTable(attachedDatabase, alias);
  }
}

class BuyerDeliveryPoint extends DataClass
    implements Insertable<BuyerDeliveryPoint> {
  final bool isDeleted;
  final DateTime timestamp;
  final DateTime? lastSyncTime;
  final bool needSync;
  final bool isNew;
  final int id;
  final int buyerId;
  final String? phone;
  final String? info;
  const BuyerDeliveryPoint({
    required this.isDeleted,
    required this.timestamp,
    this.lastSyncTime,
    required this.needSync,
    required this.isNew,
    required this.id,
    required this.buyerId,
    this.phone,
    this.info,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || lastSyncTime != null) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime);
    }
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || info != null) {
      map['info'] = Variable<String>(info);
    }
    return map;
  }

  BuyerDeliveryPointsCompanion toCompanion(bool nullToAbsent) {
    return BuyerDeliveryPointsCompanion(
      isDeleted: Value(isDeleted),
      timestamp: Value(timestamp),
      lastSyncTime:
          lastSyncTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncTime),
      id: Value(id),
      buyerId: Value(buyerId),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
    );
  }

  factory BuyerDeliveryPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuyerDeliveryPoint(
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      lastSyncTime: serializer.fromJson<DateTime?>(json['lastSyncTime']),
      needSync: serializer.fromJson<bool>(json['needSync']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      phone: serializer.fromJson<String?>(json['phone']),
      info: serializer.fromJson<String?>(json['info']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'lastSyncTime': serializer.toJson<DateTime?>(lastSyncTime),
      'needSync': serializer.toJson<bool>(needSync),
      'isNew': serializer.toJson<bool>(isNew),
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'phone': serializer.toJson<String?>(phone),
      'info': serializer.toJson<String?>(info),
    };
  }

  BuyerDeliveryPoint copyWith({
    bool? isDeleted,
    DateTime? timestamp,
    Value<DateTime?> lastSyncTime = const Value.absent(),
    bool? needSync,
    bool? isNew,
    int? id,
    int? buyerId,
    Value<String?> phone = const Value.absent(),
    Value<String?> info = const Value.absent(),
  }) => BuyerDeliveryPoint(
    isDeleted: isDeleted ?? this.isDeleted,
    timestamp: timestamp ?? this.timestamp,
    lastSyncTime: lastSyncTime.present ? lastSyncTime.value : this.lastSyncTime,
    needSync: needSync ?? this.needSync,
    isNew: isNew ?? this.isNew,
    id: id ?? this.id,
    buyerId: buyerId ?? this.buyerId,
    phone: phone.present ? phone.value : this.phone,
    info: info.present ? info.value : this.info,
  );
  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryPoint(')
          ..write('isDeleted: $isDeleted, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('needSync: $needSync, ')
          ..write('isNew: $isNew, ')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('phone: $phone, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    isDeleted,
    timestamp,
    lastSyncTime,
    needSync,
    isNew,
    id,
    buyerId,
    phone,
    info,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuyerDeliveryPoint &&
          other.isDeleted == this.isDeleted &&
          other.timestamp == this.timestamp &&
          other.lastSyncTime == this.lastSyncTime &&
          other.needSync == this.needSync &&
          other.isNew == this.isNew &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.phone == this.phone &&
          other.info == this.info);
}

class BuyerDeliveryPointsCompanion extends UpdateCompanion<BuyerDeliveryPoint> {
  final Value<bool> isDeleted;
  final Value<DateTime> timestamp;
  final Value<DateTime?> lastSyncTime;
  final Value<int> id;
  final Value<int> buyerId;
  final Value<String?> phone;
  final Value<String?> info;
  const BuyerDeliveryPointsCompanion({
    this.isDeleted = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.phone = const Value.absent(),
    this.info = const Value.absent(),
  });
  BuyerDeliveryPointsCompanion.insert({
    this.isDeleted = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.id = const Value.absent(),
    required int buyerId,
    this.phone = const Value.absent(),
    this.info = const Value.absent(),
  }) : buyerId = Value(buyerId);
  static Insertable<BuyerDeliveryPoint> custom({
    Expression<bool>? isDeleted,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? lastSyncTime,
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<String>? phone,
    Expression<String>? info,
  }) {
    return RawValuesInsertable({
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (timestamp != null) 'timestamp': timestamp,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (phone != null) 'phone': phone,
      if (info != null) 'info': info,
    });
  }

  BuyerDeliveryPointsCompanion copyWith({
    Value<bool>? isDeleted,
    Value<DateTime>? timestamp,
    Value<DateTime?>? lastSyncTime,
    Value<int>? id,
    Value<int>? buyerId,
    Value<String?>? phone,
    Value<String?>? info,
  }) {
    return BuyerDeliveryPointsCompanion(
      isDeleted: isDeleted ?? this.isDeleted,
      timestamp: timestamp ?? this.timestamp,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      phone: phone ?? this.phone,
      info: info ?? this.info,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<int>(buyerId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryPointsCompanion(')
          ..write('isDeleted: $isDeleted, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('phone: $phone, ')
          ..write('info: $info')
          ..write(')'))
        .toString();
  }
}

class $BuyerDeliveryPointPhotosTable extends BuyerDeliveryPointPhotos
    with TableInfo<$BuyerDeliveryPointPhotosTable, BuyerDeliveryPointPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuyerDeliveryPointPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastSyncTimeMeta = const VerificationMeta(
    'lastSyncTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncTime = GeneratedColumn<DateTime>(
    'last_sync_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needSyncMeta = const VerificationMeta(
    'needSync',
  );
  @override
  late final GeneratedColumn<bool> needSync = GeneratedColumn<bool>(
    'need_sync',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      (isNew & BooleanExpressionOperators(isDeleted).not()) |
          (BooleanExpressionOperators(isNew).not() &
              ComparableExpr(lastSyncTime).isSmallerThan(timestamp)),
      true,
    ),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("need_sync" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    generatedAs: GeneratedAs(lastSyncTime.isNull(), false),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyerDeliveryPointIdMeta =
      const VerificationMeta('buyerDeliveryPointId');
  @override
  late final GeneratedColumn<int> buyerDeliveryPointId = GeneratedColumn<int>(
    'buyer_delivery_point_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    isDeleted,
    timestamp,
    lastSyncTime,
    needSync,
    isNew,
    id,
    buyerDeliveryPointId,
    url,
    key,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buyer_delivery_point_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<BuyerDeliveryPointPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
        _lastSyncTimeMeta,
        lastSyncTime.isAcceptableOrUnknown(
          data['last_sync_time']!,
          _lastSyncTimeMeta,
        ),
      );
    }
    if (data.containsKey('need_sync')) {
      context.handle(
        _needSyncMeta,
        needSync.isAcceptableOrUnknown(data['need_sync']!, _needSyncMeta),
      );
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_delivery_point_id')) {
      context.handle(
        _buyerDeliveryPointIdMeta,
        buyerDeliveryPointId.isAcceptableOrUnknown(
          data['buyer_delivery_point_id']!,
          _buyerDeliveryPointIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_buyerDeliveryPointIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuyerDeliveryPointPhoto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuyerDeliveryPointPhoto(
      isDeleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_deleted'],
          )!,
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
      lastSyncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_time'],
      ),
      needSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}need_sync'],
          )!,
      isNew:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_new'],
          )!,
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerDeliveryPointId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_delivery_point_id'],
          )!,
      url:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}url'],
          )!,
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
    );
  }

  @override
  $BuyerDeliveryPointPhotosTable createAlias(String alias) {
    return $BuyerDeliveryPointPhotosTable(attachedDatabase, alias);
  }
}

class BuyerDeliveryPointPhoto extends DataClass
    implements Insertable<BuyerDeliveryPointPhoto> {
  final bool isDeleted;
  final DateTime timestamp;
  final DateTime? lastSyncTime;
  final bool needSync;
  final bool isNew;
  final int id;
  final int buyerDeliveryPointId;
  final String url;
  final String key;
  const BuyerDeliveryPointPhoto({
    required this.isDeleted,
    required this.timestamp,
    this.lastSyncTime,
    required this.needSync,
    required this.isNew,
    required this.id,
    required this.buyerDeliveryPointId,
    required this.url,
    required this.key,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || lastSyncTime != null) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime);
    }
    map['id'] = Variable<int>(id);
    map['buyer_delivery_point_id'] = Variable<int>(buyerDeliveryPointId);
    map['url'] = Variable<String>(url);
    map['key'] = Variable<String>(key);
    return map;
  }

  BuyerDeliveryPointPhotosCompanion toCompanion(bool nullToAbsent) {
    return BuyerDeliveryPointPhotosCompanion(
      isDeleted: Value(isDeleted),
      timestamp: Value(timestamp),
      lastSyncTime:
          lastSyncTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncTime),
      id: Value(id),
      buyerDeliveryPointId: Value(buyerDeliveryPointId),
      url: Value(url),
      key: Value(key),
    );
  }

  factory BuyerDeliveryPointPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuyerDeliveryPointPhoto(
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      lastSyncTime: serializer.fromJson<DateTime?>(json['lastSyncTime']),
      needSync: serializer.fromJson<bool>(json['needSync']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      id: serializer.fromJson<int>(json['id']),
      buyerDeliveryPointId: serializer.fromJson<int>(
        json['buyerDeliveryPointId'],
      ),
      url: serializer.fromJson<String>(json['url']),
      key: serializer.fromJson<String>(json['key']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'lastSyncTime': serializer.toJson<DateTime?>(lastSyncTime),
      'needSync': serializer.toJson<bool>(needSync),
      'isNew': serializer.toJson<bool>(isNew),
      'id': serializer.toJson<int>(id),
      'buyerDeliveryPointId': serializer.toJson<int>(buyerDeliveryPointId),
      'url': serializer.toJson<String>(url),
      'key': serializer.toJson<String>(key),
    };
  }

  BuyerDeliveryPointPhoto copyWith({
    bool? isDeleted,
    DateTime? timestamp,
    Value<DateTime?> lastSyncTime = const Value.absent(),
    bool? needSync,
    bool? isNew,
    int? id,
    int? buyerDeliveryPointId,
    String? url,
    String? key,
  }) => BuyerDeliveryPointPhoto(
    isDeleted: isDeleted ?? this.isDeleted,
    timestamp: timestamp ?? this.timestamp,
    lastSyncTime: lastSyncTime.present ? lastSyncTime.value : this.lastSyncTime,
    needSync: needSync ?? this.needSync,
    isNew: isNew ?? this.isNew,
    id: id ?? this.id,
    buyerDeliveryPointId: buyerDeliveryPointId ?? this.buyerDeliveryPointId,
    url: url ?? this.url,
    key: key ?? this.key,
  );
  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryPointPhoto(')
          ..write('isDeleted: $isDeleted, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('needSync: $needSync, ')
          ..write('isNew: $isNew, ')
          ..write('id: $id, ')
          ..write('buyerDeliveryPointId: $buyerDeliveryPointId, ')
          ..write('url: $url, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    isDeleted,
    timestamp,
    lastSyncTime,
    needSync,
    isNew,
    id,
    buyerDeliveryPointId,
    url,
    key,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuyerDeliveryPointPhoto &&
          other.isDeleted == this.isDeleted &&
          other.timestamp == this.timestamp &&
          other.lastSyncTime == this.lastSyncTime &&
          other.needSync == this.needSync &&
          other.isNew == this.isNew &&
          other.id == this.id &&
          other.buyerDeliveryPointId == this.buyerDeliveryPointId &&
          other.url == this.url &&
          other.key == this.key);
}

class BuyerDeliveryPointPhotosCompanion
    extends UpdateCompanion<BuyerDeliveryPointPhoto> {
  final Value<bool> isDeleted;
  final Value<DateTime> timestamp;
  final Value<DateTime?> lastSyncTime;
  final Value<int> id;
  final Value<int> buyerDeliveryPointId;
  final Value<String> url;
  final Value<String> key;
  const BuyerDeliveryPointPhotosCompanion({
    this.isDeleted = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.id = const Value.absent(),
    this.buyerDeliveryPointId = const Value.absent(),
    this.url = const Value.absent(),
    this.key = const Value.absent(),
  });
  BuyerDeliveryPointPhotosCompanion.insert({
    this.isDeleted = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.id = const Value.absent(),
    required int buyerDeliveryPointId,
    required String url,
    required String key,
  }) : buyerDeliveryPointId = Value(buyerDeliveryPointId),
       url = Value(url),
       key = Value(key);
  static Insertable<BuyerDeliveryPointPhoto> custom({
    Expression<bool>? isDeleted,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? lastSyncTime,
    Expression<int>? id,
    Expression<int>? buyerDeliveryPointId,
    Expression<String>? url,
    Expression<String>? key,
  }) {
    return RawValuesInsertable({
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (timestamp != null) 'timestamp': timestamp,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
      if (id != null) 'id': id,
      if (buyerDeliveryPointId != null)
        'buyer_delivery_point_id': buyerDeliveryPointId,
      if (url != null) 'url': url,
      if (key != null) 'key': key,
    });
  }

  BuyerDeliveryPointPhotosCompanion copyWith({
    Value<bool>? isDeleted,
    Value<DateTime>? timestamp,
    Value<DateTime?>? lastSyncTime,
    Value<int>? id,
    Value<int>? buyerDeliveryPointId,
    Value<String>? url,
    Value<String>? key,
  }) {
    return BuyerDeliveryPointPhotosCompanion(
      isDeleted: isDeleted ?? this.isDeleted,
      timestamp: timestamp ?? this.timestamp,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      id: id ?? this.id,
      buyerDeliveryPointId: buyerDeliveryPointId ?? this.buyerDeliveryPointId,
      url: url ?? this.url,
      key: key ?? this.key,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buyerDeliveryPointId.present) {
      map['buyer_delivery_point_id'] = Variable<int>(
        buyerDeliveryPointId.value,
      );
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuyerDeliveryPointPhotosCompanion(')
          ..write('isDeleted: $isDeleted, ')
          ..write('timestamp: $timestamp, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('id: $id, ')
          ..write('buyerDeliveryPointId: $buyerDeliveryPointId, ')
          ..write('url: $url, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }
}

class $PrefsTable extends Prefs with TableInfo<$PrefsTable, Pref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lastLoadTimeMeta = const VerificationMeta(
    'lastLoadTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastLoadTime = GeneratedColumn<DateTime>(
    'last_load_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [lastLoadTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pref> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('last_load_time')) {
      context.handle(
        _lastLoadTimeMeta,
        lastLoadTime.isAcceptableOrUnknown(
          data['last_load_time']!,
          _lastLoadTimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Pref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pref(
      lastLoadTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_load_time'],
      ),
    );
  }

  @override
  $PrefsTable createAlias(String alias) {
    return $PrefsTable(attachedDatabase, alias);
  }
}

class Pref extends DataClass implements Insertable<Pref> {
  final DateTime? lastLoadTime;
  const Pref({this.lastLoadTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || lastLoadTime != null) {
      map['last_load_time'] = Variable<DateTime>(lastLoadTime);
    }
    return map;
  }

  PrefsCompanion toCompanion(bool nullToAbsent) {
    return PrefsCompanion(
      lastLoadTime:
          lastLoadTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastLoadTime),
    );
  }

  factory Pref.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pref(
      lastLoadTime: serializer.fromJson<DateTime?>(json['lastLoadTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lastLoadTime': serializer.toJson<DateTime?>(lastLoadTime),
    };
  }

  Pref copyWith({Value<DateTime?> lastLoadTime = const Value.absent()}) => Pref(
    lastLoadTime: lastLoadTime.present ? lastLoadTime.value : this.lastLoadTime,
  );
  Pref copyWithCompanion(PrefsCompanion data) {
    return Pref(
      lastLoadTime:
          data.lastLoadTime.present
              ? data.lastLoadTime.value
              : this.lastLoadTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pref(')
          ..write('lastLoadTime: $lastLoadTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => lastLoadTime.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pref && other.lastLoadTime == this.lastLoadTime);
}

class PrefsCompanion extends UpdateCompanion<Pref> {
  final Value<DateTime?> lastLoadTime;
  final Value<int> rowid;
  const PrefsCompanion({
    this.lastLoadTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrefsCompanion.insert({
    this.lastLoadTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<Pref> custom({
    Expression<DateTime>? lastLoadTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lastLoadTime != null) 'last_load_time': lastLoadTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrefsCompanion copyWith({Value<DateTime?>? lastLoadTime, Value<int>? rowid}) {
    return PrefsCompanion(
      lastLoadTime: lastLoadTime ?? this.lastLoadTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lastLoadTime.present) {
      map['last_load_time'] = Variable<DateTime>(lastLoadTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrefsCompanion(')
          ..write('lastLoadTime: $lastLoadTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeliveriesTable extends Deliveries
    with TableInfo<$DeliveriesTable, Delivery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ndocMeta = const VerificationMeta('ndoc');
  @override
  late final GeneratedColumn<String> ndoc = GeneratedColumn<String>(
    'ndoc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ddatebMeta = const VerificationMeta('ddateb');
  @override
  late final GeneratedColumn<DateTime> ddateb = GeneratedColumn<DateTime>(
    'ddateb',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ndoc, ddateb];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deliveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Delivery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ndoc')) {
      context.handle(
        _ndocMeta,
        ndoc.isAcceptableOrUnknown(data['ndoc']!, _ndocMeta),
      );
    } else if (isInserting) {
      context.missing(_ndocMeta);
    }
    if (data.containsKey('ddateb')) {
      context.handle(
        _ddatebMeta,
        ddateb.isAcceptableOrUnknown(data['ddateb']!, _ddatebMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Delivery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Delivery(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ndoc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ndoc'],
          )!,
      ddateb: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ddateb'],
      ),
    );
  }

  @override
  $DeliveriesTable createAlias(String alias) {
    return $DeliveriesTable(attachedDatabase, alias);
  }
}

class Delivery extends DataClass implements Insertable<Delivery> {
  final int id;
  final String ndoc;
  final DateTime? ddateb;
  const Delivery({required this.id, required this.ndoc, this.ddateb});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ndoc'] = Variable<String>(ndoc);
    if (!nullToAbsent || ddateb != null) {
      map['ddateb'] = Variable<DateTime>(ddateb);
    }
    return map;
  }

  DeliveriesCompanion toCompanion(bool nullToAbsent) {
    return DeliveriesCompanion(
      id: Value(id),
      ndoc: Value(ndoc),
      ddateb:
          ddateb == null && nullToAbsent ? const Value.absent() : Value(ddateb),
    );
  }

  factory Delivery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Delivery(
      id: serializer.fromJson<int>(json['id']),
      ndoc: serializer.fromJson<String>(json['ndoc']),
      ddateb: serializer.fromJson<DateTime?>(json['ddateb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ndoc': serializer.toJson<String>(ndoc),
      'ddateb': serializer.toJson<DateTime?>(ddateb),
    };
  }

  Delivery copyWith({
    int? id,
    String? ndoc,
    Value<DateTime?> ddateb = const Value.absent(),
  }) => Delivery(
    id: id ?? this.id,
    ndoc: ndoc ?? this.ndoc,
    ddateb: ddateb.present ? ddateb.value : this.ddateb,
  );
  Delivery copyWithCompanion(DeliveriesCompanion data) {
    return Delivery(
      id: data.id.present ? data.id.value : this.id,
      ndoc: data.ndoc.present ? data.ndoc.value : this.ndoc,
      ddateb: data.ddateb.present ? data.ddateb.value : this.ddateb,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Delivery(')
          ..write('id: $id, ')
          ..write('ndoc: $ndoc, ')
          ..write('ddateb: $ddateb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ndoc, ddateb);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Delivery &&
          other.id == this.id &&
          other.ndoc == this.ndoc &&
          other.ddateb == this.ddateb);
}

class DeliveriesCompanion extends UpdateCompanion<Delivery> {
  final Value<int> id;
  final Value<String> ndoc;
  final Value<DateTime?> ddateb;
  const DeliveriesCompanion({
    this.id = const Value.absent(),
    this.ndoc = const Value.absent(),
    this.ddateb = const Value.absent(),
  });
  DeliveriesCompanion.insert({
    this.id = const Value.absent(),
    required String ndoc,
    this.ddateb = const Value.absent(),
  }) : ndoc = Value(ndoc);
  static Insertable<Delivery> custom({
    Expression<int>? id,
    Expression<String>? ndoc,
    Expression<DateTime>? ddateb,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ndoc != null) 'ndoc': ndoc,
      if (ddateb != null) 'ddateb': ddateb,
    });
  }

  DeliveriesCompanion copyWith({
    Value<int>? id,
    Value<String>? ndoc,
    Value<DateTime?>? ddateb,
  }) {
    return DeliveriesCompanion(
      id: id ?? this.id,
      ndoc: ndoc ?? this.ndoc,
      ddateb: ddateb ?? this.ddateb,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ndoc.present) {
      map['ndoc'] = Variable<String>(ndoc.value);
    }
    if (ddateb.present) {
      map['ddateb'] = Variable<DateTime>(ddateb.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveriesCompanion(')
          ..write('id: $id, ')
          ..write('ndoc: $ndoc, ')
          ..write('ddateb: $ddateb')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buyerIdMeta = const VerificationMeta(
    'buyerId',
  );
  @override
  late final GeneratedColumn<int> buyerId = GeneratedColumn<int>(
    'buyer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryIdMeta = const VerificationMeta(
    'deliveryId',
  );
  @override
  late final GeneratedColumn<int> deliveryId = GeneratedColumn<int>(
    'delivery_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskTypeNameMeta = const VerificationMeta(
    'taskTypeName',
  );
  @override
  late final GeneratedColumn<String> taskTypeName = GeneratedColumn<String>(
    'task_type_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskNumberMeta = const VerificationMeta(
    'taskNumber',
  );
  @override
  late final GeneratedColumn<String> taskNumber = GeneratedColumn<String>(
    'task_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infoMeta = const VerificationMeta('info');
  @override
  late final GeneratedColumn<String> info = GeneratedColumn<String>(
    'info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buyerId,
    deliveryId,
    taskTypeName,
    taskNumber,
    info,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buyer_id')) {
      context.handle(
        _buyerIdMeta,
        buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('delivery_id')) {
      context.handle(
        _deliveryIdMeta,
        deliveryId.isAcceptableOrUnknown(data['delivery_id']!, _deliveryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deliveryIdMeta);
    }
    if (data.containsKey('task_type_name')) {
      context.handle(
        _taskTypeNameMeta,
        taskTypeName.isAcceptableOrUnknown(
          data['task_type_name']!,
          _taskTypeNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskTypeNameMeta);
    }
    if (data.containsKey('task_number')) {
      context.handle(
        _taskNumberMeta,
        taskNumber.isAcceptableOrUnknown(data['task_number']!, _taskNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_taskNumberMeta);
    }
    if (data.containsKey('info')) {
      context.handle(
        _infoMeta,
        info.isAcceptableOrUnknown(data['info']!, _infoMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      buyerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}buyer_id'],
          )!,
      deliveryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}delivery_id'],
          )!,
      taskTypeName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}task_type_name'],
          )!,
      taskNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}task_number'],
          )!,
      info: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}info'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final int buyerId;
  final int deliveryId;
  final String taskTypeName;
  final String taskNumber;
  final String? info;
  final bool? completed;
  const Task({
    required this.id,
    required this.buyerId,
    required this.deliveryId,
    required this.taskTypeName,
    required this.taskNumber,
    this.info,
    this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['delivery_id'] = Variable<int>(deliveryId);
    map['task_type_name'] = Variable<String>(taskTypeName);
    map['task_number'] = Variable<String>(taskNumber);
    if (!nullToAbsent || info != null) {
      map['info'] = Variable<String>(info);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      deliveryId: Value(deliveryId),
      taskTypeName: Value(taskTypeName),
      taskNumber: Value(taskNumber),
      info: info == null && nullToAbsent ? const Value.absent() : Value(info),
      completed:
          completed == null && nullToAbsent
              ? const Value.absent()
              : Value(completed),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      buyerId: serializer.fromJson<int>(json['buyerId']),
      deliveryId: serializer.fromJson<int>(json['deliveryId']),
      taskTypeName: serializer.fromJson<String>(json['taskTypeName']),
      taskNumber: serializer.fromJson<String>(json['taskNumber']),
      info: serializer.fromJson<String?>(json['info']),
      completed: serializer.fromJson<bool?>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buyerId': serializer.toJson<int>(buyerId),
      'deliveryId': serializer.toJson<int>(deliveryId),
      'taskTypeName': serializer.toJson<String>(taskTypeName),
      'taskNumber': serializer.toJson<String>(taskNumber),
      'info': serializer.toJson<String?>(info),
      'completed': serializer.toJson<bool?>(completed),
    };
  }

  Task copyWith({
    int? id,
    int? buyerId,
    int? deliveryId,
    String? taskTypeName,
    String? taskNumber,
    Value<String?> info = const Value.absent(),
    Value<bool?> completed = const Value.absent(),
  }) => Task(
    id: id ?? this.id,
    buyerId: buyerId ?? this.buyerId,
    deliveryId: deliveryId ?? this.deliveryId,
    taskTypeName: taskTypeName ?? this.taskTypeName,
    taskNumber: taskNumber ?? this.taskNumber,
    info: info.present ? info.value : this.info,
    completed: completed.present ? completed.value : this.completed,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      deliveryId:
          data.deliveryId.present ? data.deliveryId.value : this.deliveryId,
      taskTypeName:
          data.taskTypeName.present
              ? data.taskTypeName.value
              : this.taskTypeName,
      taskNumber:
          data.taskNumber.present ? data.taskNumber.value : this.taskNumber,
      info: data.info.present ? data.info.value : this.info,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('taskTypeName: $taskTypeName, ')
          ..write('taskNumber: $taskNumber, ')
          ..write('info: $info, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    buyerId,
    deliveryId,
    taskTypeName,
    taskNumber,
    info,
    completed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.deliveryId == this.deliveryId &&
          other.taskTypeName == this.taskTypeName &&
          other.taskNumber == this.taskNumber &&
          other.info == this.info &&
          other.completed == this.completed);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<int> buyerId;
  final Value<int> deliveryId;
  final Value<String> taskTypeName;
  final Value<String> taskNumber;
  final Value<String?> info;
  final Value<bool?> completed;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.deliveryId = const Value.absent(),
    this.taskTypeName = const Value.absent(),
    this.taskNumber = const Value.absent(),
    this.info = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required int buyerId,
    required int deliveryId,
    required String taskTypeName,
    required String taskNumber,
    this.info = const Value.absent(),
    this.completed = const Value.absent(),
  }) : buyerId = Value(buyerId),
       deliveryId = Value(deliveryId),
       taskTypeName = Value(taskTypeName),
       taskNumber = Value(taskNumber);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<int>? buyerId,
    Expression<int>? deliveryId,
    Expression<String>? taskTypeName,
    Expression<String>? taskNumber,
    Expression<String>? info,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (taskTypeName != null) 'task_type_name': taskTypeName,
      if (taskNumber != null) 'task_number': taskNumber,
      if (info != null) 'info': info,
      if (completed != null) 'completed': completed,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<int>? buyerId,
    Value<int>? deliveryId,
    Value<String>? taskTypeName,
    Value<String>? taskNumber,
    Value<String?>? info,
    Value<bool?>? completed,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      deliveryId: deliveryId ?? this.deliveryId,
      taskTypeName: taskTypeName ?? this.taskTypeName,
      taskNumber: taskNumber ?? this.taskNumber,
      info: info ?? this.info,
      completed: completed ?? this.completed,
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
    if (deliveryId.present) {
      map['delivery_id'] = Variable<int>(deliveryId.value);
    }
    if (taskTypeName.present) {
      map['task_type_name'] = Variable<String>(taskTypeName.value);
    }
    if (taskNumber.present) {
      map['task_number'] = Variable<String>(taskNumber.value);
    }
    if (info.present) {
      map['info'] = Variable<String>(info.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('taskTypeName: $taskTypeName, ')
          ..write('taskNumber: $taskNumber, ')
          ..write('info: $info, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataStore extends GeneratedDatabase {
  _$AppDataStore(QueryExecutor e) : super(e);
  $AppDataStoreManager get managers => $AppDataStoreManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ReceptsTable recepts = $ReceptsTable(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $BuyersTable buyers = $BuyersTable(this);
  late final $CashPaymentsTable cashPayments = $CashPaymentsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $OrderLineCodesTable orderLineCodes = $OrderLineCodesTable(this);
  late final $OrderLineStorageCodesTable orderLineStorageCodes =
      $OrderLineStorageCodesTable(this);
  late final $OrderLinePackErrorsTable orderLinePackErrors =
      $OrderLinePackErrorsTable(this);
  late final $BuyerDeliveryMarksTable buyerDeliveryMarks =
      $BuyerDeliveryMarksTable(this);
  late final $BuyerDeliveryPointsTable buyerDeliveryPoints =
      $BuyerDeliveryPointsTable(this);
  late final $BuyerDeliveryPointPhotosTable buyerDeliveryPointPhotos =
      $BuyerDeliveryPointPhotosTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final $DeliveriesTable deliveries = $DeliveriesTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final BuyersDao buyersDao = BuyersDao(this as AppDataStore);
  late final OrdersDao ordersDao = OrdersDao(this as AppDataStore);
  late final PaymentsDao paymentsDao = PaymentsDao(this as AppDataStore);
  late final UsersDao usersDao = UsersDao(this as AppDataStore);
  late final TasksDao tasksDao = TasksDao(this as AppDataStore);
  Selectable<AppInfoResult> appInfo() {
    return customSelect(
      'SELECT prefs.*, (SELECT COUNT(*) FROM orders) AS orders_total, EXISTS (SELECT 1 AS _c0 FROM buyer_delivery_marks WHERE id IS NULL) AS has_unsynced, EXISTS (SELECT 1 AS _c1 FROM buyer_delivery_marks WHERE id IS NULL) OR EXISTS (SELECT 1 AS _c2 FROM order_line_codes WHERE id IS NULL) AS has_unsaved, (SELECT COUNT(*) FROM orders WHERE is_inc = 1) + (SELECT COUNT(*) FROM orders WHERE NOT EXISTS (SELECT 1 FROM buyers WHERE buyers.buyer_id = orders.buyer_id) = 1) AS inc_orders_total, (SELECT COUNT(*) FROM buyers) AS buyers_total FROM prefs',
      variables: [],
      readsFrom: {orders, buyerDeliveryMarks, orderLineCodes, buyers, prefs},
    ).map(
      (QueryRow row) => AppInfoResult(
        lastLoadTime: row.readNullable<DateTime>('last_load_time'),
        ordersTotal: row.read<int>('orders_total'),
        hasUnsynced: row.read<bool>('has_unsynced'),
        hasUnsaved: row.read<bool>('has_unsaved'),
        incOrdersTotal: row.read<int>('inc_orders_total'),
        buyersTotal: row.read<int>('buyers_total'),
      ),
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    recepts,
    incomes,
    buyers,
    cashPayments,
    debts,
    orders,
    orderLines,
    orderLineCodes,
    orderLineStorageCodes,
    orderLinePackErrors,
    buyerDeliveryMarks,
    buyerDeliveryPoints,
    buyerDeliveryPointPhotos,
    prefs,
    deliveries,
    tasks,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String salesmanName,
      required String email,
      required bool closed,
      required String version,
      required double total,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> salesmanName,
      Value<String> email,
      Value<bool> closed,
      Value<String> version,
      Value<double> total,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDataStore, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salesmanName => $composableBuilder(
    column: $table.salesmanName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get closed => $composableBuilder(
    column: $table.closed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDataStore, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salesmanName => $composableBuilder(
    column: $table.salesmanName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get closed => $composableBuilder(
    column: $table.closed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDataStore, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get salesmanName => $composableBuilder(
    column: $table.salesmanName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get closed =>
      $composableBuilder(column: $table.closed, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDataStore, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDataStore db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> salesmanName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<bool> closed = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<double> total = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                salesmanName: salesmanName,
                email: email,
                closed: closed,
                version: version,
                total: total,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String salesmanName,
                required String email,
                required bool closed,
                required String version,
                required double total,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                salesmanName: salesmanName,
                email: email,
                closed: closed,
                version: version,
                total: total,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDataStore, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$ReceptsTableCreateCompanionBuilder =
    ReceptsCompanion Function({
      Value<int> id,
      required DateTime ddate,
      required double summ,
    });
typedef $$ReceptsTableUpdateCompanionBuilder =
    ReceptsCompanion Function({
      Value<int> id,
      Value<DateTime> ddate,
      Value<double> summ,
    });

class $$ReceptsTableFilterComposer
    extends Composer<_$AppDataStore, $ReceptsTable> {
  $$ReceptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceptsTableOrderingComposer
    extends Composer<_$AppDataStore, $ReceptsTable> {
  $$ReceptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceptsTableAnnotationComposer
    extends Composer<_$AppDataStore, $ReceptsTable> {
  $$ReceptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get ddate =>
      $composableBuilder(column: $table.ddate, builder: (column) => column);

  GeneratedColumn<double> get summ =>
      $composableBuilder(column: $table.summ, builder: (column) => column);
}

class $$ReceptsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $ReceptsTable,
          Recept,
          $$ReceptsTableFilterComposer,
          $$ReceptsTableOrderingComposer,
          $$ReceptsTableAnnotationComposer,
          $$ReceptsTableCreateCompanionBuilder,
          $$ReceptsTableUpdateCompanionBuilder,
          (Recept, BaseReferences<_$AppDataStore, $ReceptsTable, Recept>),
          Recept,
          PrefetchHooks Function()
        > {
  $$ReceptsTableTableManager(_$AppDataStore db, $ReceptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReceptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ReceptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReceptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> ddate = const Value.absent(),
                Value<double> summ = const Value.absent(),
              }) => ReceptsCompanion(id: id, ddate: ddate, summ: summ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime ddate,
                required double summ,
              }) => ReceptsCompanion.insert(id: id, ddate: ddate, summ: summ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $ReceptsTable,
      Recept,
      $$ReceptsTableFilterComposer,
      $$ReceptsTableOrderingComposer,
      $$ReceptsTableAnnotationComposer,
      $$ReceptsTableCreateCompanionBuilder,
      $$ReceptsTableUpdateCompanionBuilder,
      (Recept, BaseReferences<_$AppDataStore, $ReceptsTable, Recept>),
      Recept,
      PrefetchHooks Function()
    >;
typedef $$IncomesTableCreateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      required DateTime ddate,
      required double summ,
    });
typedef $$IncomesTableUpdateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      Value<DateTime> ddate,
      Value<double> summ,
    });

class $$IncomesTableFilterComposer
    extends Composer<_$AppDataStore, $IncomesTable> {
  $$IncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomesTableOrderingComposer
    extends Composer<_$AppDataStore, $IncomesTable> {
  $$IncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomesTableAnnotationComposer
    extends Composer<_$AppDataStore, $IncomesTable> {
  $$IncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get ddate =>
      $composableBuilder(column: $table.ddate, builder: (column) => column);

  GeneratedColumn<double> get summ =>
      $composableBuilder(column: $table.summ, builder: (column) => column);
}

class $$IncomesTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $IncomesTable,
          Income,
          $$IncomesTableFilterComposer,
          $$IncomesTableOrderingComposer,
          $$IncomesTableAnnotationComposer,
          $$IncomesTableCreateCompanionBuilder,
          $$IncomesTableUpdateCompanionBuilder,
          (Income, BaseReferences<_$AppDataStore, $IncomesTable, Income>),
          Income,
          PrefetchHooks Function()
        > {
  $$IncomesTableTableManager(_$AppDataStore db, $IncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$IncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$IncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$IncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> ddate = const Value.absent(),
                Value<double> summ = const Value.absent(),
              }) => IncomesCompanion(id: id, ddate: ddate, summ: summ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime ddate,
                required double summ,
              }) => IncomesCompanion.insert(id: id, ddate: ddate, summ: summ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $IncomesTable,
      Income,
      $$IncomesTableFilterComposer,
      $$IncomesTableOrderingComposer,
      $$IncomesTableAnnotationComposer,
      $$IncomesTableCreateCompanionBuilder,
      $$IncomesTableUpdateCompanionBuilder,
      (Income, BaseReferences<_$AppDataStore, $IncomesTable, Income>),
      Income,
      PrefetchHooks Function()
    >;
typedef $$BuyersTableCreateCompanionBuilder =
    BuyersCompanion Function({
      required int buyerId,
      required int deliveryId,
      required String name,
      required String address,
      required int ord,
      required bool needInc,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> groupName,
      Value<String?> groupPhone,
      Value<int> rowid,
    });
typedef $$BuyersTableUpdateCompanionBuilder =
    BuyersCompanion Function({
      Value<int> buyerId,
      Value<int> deliveryId,
      Value<String> name,
      Value<String> address,
      Value<int> ord,
      Value<bool> needInc,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> groupName,
      Value<String?> groupPhone,
      Value<int> rowid,
    });

class $$BuyersTableFilterComposer
    extends Composer<_$AppDataStore, $BuyersTable> {
  $$BuyersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needInc => $composableBuilder(
    column: $table.needInc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupPhone => $composableBuilder(
    column: $table.groupPhone,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuyersTableOrderingComposer
    extends Composer<_$AppDataStore, $BuyersTable> {
  $$BuyersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needInc => $composableBuilder(
    column: $table.needInc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupPhone => $composableBuilder(
    column: $table.groupPhone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuyersTableAnnotationComposer
    extends Composer<_$AppDataStore, $BuyersTable> {
  $$BuyersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get ord =>
      $composableBuilder(column: $table.ord, builder: (column) => column);

  GeneratedColumn<bool> get needInc =>
      $composableBuilder(column: $table.needInc, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get groupPhone => $composableBuilder(
    column: $table.groupPhone,
    builder: (column) => column,
  );
}

class $$BuyersTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $BuyersTable,
          Buyer,
          $$BuyersTableFilterComposer,
          $$BuyersTableOrderingComposer,
          $$BuyersTableAnnotationComposer,
          $$BuyersTableCreateCompanionBuilder,
          $$BuyersTableUpdateCompanionBuilder,
          (Buyer, BaseReferences<_$AppDataStore, $BuyersTable, Buyer>),
          Buyer,
          PrefetchHooks Function()
        > {
  $$BuyersTableTableManager(_$AppDataStore db, $BuyersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BuyersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BuyersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BuyersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> buyerId = const Value.absent(),
                Value<int> deliveryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> ord = const Value.absent(),
                Value<bool> needInc = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<String?> groupPhone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuyersCompanion(
                buyerId: buyerId,
                deliveryId: deliveryId,
                name: name,
                address: address,
                ord: ord,
                needInc: needInc,
                latitude: latitude,
                longitude: longitude,
                groupName: groupName,
                groupPhone: groupPhone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int buyerId,
                required int deliveryId,
                required String name,
                required String address,
                required int ord,
                required bool needInc,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<String?> groupPhone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuyersCompanion.insert(
                buyerId: buyerId,
                deliveryId: deliveryId,
                name: name,
                address: address,
                ord: ord,
                needInc: needInc,
                latitude: latitude,
                longitude: longitude,
                groupName: groupName,
                groupPhone: groupPhone,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuyersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $BuyersTable,
      Buyer,
      $$BuyersTableFilterComposer,
      $$BuyersTableOrderingComposer,
      $$BuyersTableAnnotationComposer,
      $$BuyersTableCreateCompanionBuilder,
      $$BuyersTableUpdateCompanionBuilder,
      (Buyer, BaseReferences<_$AppDataStore, $BuyersTable, Buyer>),
      Buyer,
      PrefetchHooks Function()
    >;
typedef $$CashPaymentsTableCreateCompanionBuilder =
    CashPaymentsCompanion Function({
      Value<int> id,
      required int buyerId,
      required int orderId,
      required double summ,
      required DateTime ddate,
      required bool kkmprinted,
    });
typedef $$CashPaymentsTableUpdateCompanionBuilder =
    CashPaymentsCompanion Function({
      Value<int> id,
      Value<int> buyerId,
      Value<int> orderId,
      Value<double> summ,
      Value<DateTime> ddate,
      Value<bool> kkmprinted,
    });

class $$CashPaymentsTableFilterComposer
    extends Composer<_$AppDataStore, $CashPaymentsTable> {
  $$CashPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get kkmprinted => $composableBuilder(
    column: $table.kkmprinted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashPaymentsTableOrderingComposer
    extends Composer<_$AppDataStore, $CashPaymentsTable> {
  $$CashPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get summ => $composableBuilder(
    column: $table.summ,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get kkmprinted => $composableBuilder(
    column: $table.kkmprinted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashPaymentsTableAnnotationComposer
    extends Composer<_$AppDataStore, $CashPaymentsTable> {
  $$CashPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<double> get summ =>
      $composableBuilder(column: $table.summ, builder: (column) => column);

  GeneratedColumn<DateTime> get ddate =>
      $composableBuilder(column: $table.ddate, builder: (column) => column);

  GeneratedColumn<bool> get kkmprinted => $composableBuilder(
    column: $table.kkmprinted,
    builder: (column) => column,
  );
}

class $$CashPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $CashPaymentsTable,
          CashPayment,
          $$CashPaymentsTableFilterComposer,
          $$CashPaymentsTableOrderingComposer,
          $$CashPaymentsTableAnnotationComposer,
          $$CashPaymentsTableCreateCompanionBuilder,
          $$CashPaymentsTableUpdateCompanionBuilder,
          (
            CashPayment,
            BaseReferences<_$AppDataStore, $CashPaymentsTable, CashPayment>,
          ),
          CashPayment,
          PrefetchHooks Function()
        > {
  $$CashPaymentsTableTableManager(_$AppDataStore db, $CashPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CashPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CashPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CashPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<double> summ = const Value.absent(),
                Value<DateTime> ddate = const Value.absent(),
                Value<bool> kkmprinted = const Value.absent(),
              }) => CashPaymentsCompanion(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                summ: summ,
                ddate: ddate,
                kkmprinted: kkmprinted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buyerId,
                required int orderId,
                required double summ,
                required DateTime ddate,
                required bool kkmprinted,
              }) => CashPaymentsCompanion.insert(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                summ: summ,
                ddate: ddate,
                kkmprinted: kkmprinted,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $CashPaymentsTable,
      CashPayment,
      $$CashPaymentsTableFilterComposer,
      $$CashPaymentsTableOrderingComposer,
      $$CashPaymentsTableAnnotationComposer,
      $$CashPaymentsTableCreateCompanionBuilder,
      $$CashPaymentsTableUpdateCompanionBuilder,
      (
        CashPayment,
        BaseReferences<_$AppDataStore, $CashPaymentsTable, CashPayment>,
      ),
      CashPayment,
      PrefetchHooks Function()
    >;
typedef $$DebtsTableCreateCompanionBuilder =
    DebtsCompanion Function({
      Value<int> id,
      required int buyerId,
      required int orderId,
      required String ndoc,
      required String orderNdoc,
      required DateTime ddate,
      required DateTime orderDdate,
      required bool isCheck,
      required double debtSum,
      required double orderSum,
      Value<double?> paidSum,
      Value<double?> paymentSum,
      required bool physical,
    });
typedef $$DebtsTableUpdateCompanionBuilder =
    DebtsCompanion Function({
      Value<int> id,
      Value<int> buyerId,
      Value<int> orderId,
      Value<String> ndoc,
      Value<String> orderNdoc,
      Value<DateTime> ddate,
      Value<DateTime> orderDdate,
      Value<bool> isCheck,
      Value<double> debtSum,
      Value<double> orderSum,
      Value<double?> paidSum,
      Value<double?> paymentSum,
      Value<bool> physical,
    });

class $$DebtsTableFilterComposer extends Composer<_$AppDataStore, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNdoc => $composableBuilder(
    column: $table.orderNdoc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderDdate => $composableBuilder(
    column: $table.orderDdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCheck => $composableBuilder(
    column: $table.isCheck,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get debtSum => $composableBuilder(
    column: $table.debtSum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get orderSum => $composableBuilder(
    column: $table.orderSum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidSum => $composableBuilder(
    column: $table.paidSum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paymentSum => $composableBuilder(
    column: $table.paymentSum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get physical => $composableBuilder(
    column: $table.physical,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDataStore, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNdoc => $composableBuilder(
    column: $table.orderNdoc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ddate => $composableBuilder(
    column: $table.ddate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderDdate => $composableBuilder(
    column: $table.orderDdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCheck => $composableBuilder(
    column: $table.isCheck,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get debtSum => $composableBuilder(
    column: $table.debtSum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get orderSum => $composableBuilder(
    column: $table.orderSum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidSum => $composableBuilder(
    column: $table.paidSum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paymentSum => $composableBuilder(
    column: $table.paymentSum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get physical => $composableBuilder(
    column: $table.physical,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDataStore, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get ndoc =>
      $composableBuilder(column: $table.ndoc, builder: (column) => column);

  GeneratedColumn<String> get orderNdoc =>
      $composableBuilder(column: $table.orderNdoc, builder: (column) => column);

  GeneratedColumn<DateTime> get ddate =>
      $composableBuilder(column: $table.ddate, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDdate => $composableBuilder(
    column: $table.orderDdate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCheck =>
      $composableBuilder(column: $table.isCheck, builder: (column) => column);

  GeneratedColumn<double> get debtSum =>
      $composableBuilder(column: $table.debtSum, builder: (column) => column);

  GeneratedColumn<double> get orderSum =>
      $composableBuilder(column: $table.orderSum, builder: (column) => column);

  GeneratedColumn<double> get paidSum =>
      $composableBuilder(column: $table.paidSum, builder: (column) => column);

  GeneratedColumn<double> get paymentSum => $composableBuilder(
    column: $table.paymentSum,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get physical =>
      $composableBuilder(column: $table.physical, builder: (column) => column);
}

class $$DebtsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $DebtsTable,
          Debt,
          $$DebtsTableFilterComposer,
          $$DebtsTableOrderingComposer,
          $$DebtsTableAnnotationComposer,
          $$DebtsTableCreateCompanionBuilder,
          $$DebtsTableUpdateCompanionBuilder,
          (Debt, BaseReferences<_$AppDataStore, $DebtsTable, Debt>),
          Debt,
          PrefetchHooks Function()
        > {
  $$DebtsTableTableManager(_$AppDataStore db, $DebtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<String> ndoc = const Value.absent(),
                Value<String> orderNdoc = const Value.absent(),
                Value<DateTime> ddate = const Value.absent(),
                Value<DateTime> orderDdate = const Value.absent(),
                Value<bool> isCheck = const Value.absent(),
                Value<double> debtSum = const Value.absent(),
                Value<double> orderSum = const Value.absent(),
                Value<double?> paidSum = const Value.absent(),
                Value<double?> paymentSum = const Value.absent(),
                Value<bool> physical = const Value.absent(),
              }) => DebtsCompanion(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                ndoc: ndoc,
                orderNdoc: orderNdoc,
                ddate: ddate,
                orderDdate: orderDdate,
                isCheck: isCheck,
                debtSum: debtSum,
                orderSum: orderSum,
                paidSum: paidSum,
                paymentSum: paymentSum,
                physical: physical,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buyerId,
                required int orderId,
                required String ndoc,
                required String orderNdoc,
                required DateTime ddate,
                required DateTime orderDdate,
                required bool isCheck,
                required double debtSum,
                required double orderSum,
                Value<double?> paidSum = const Value.absent(),
                Value<double?> paymentSum = const Value.absent(),
                required bool physical,
              }) => DebtsCompanion.insert(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                ndoc: ndoc,
                orderNdoc: orderNdoc,
                ddate: ddate,
                orderDdate: orderDdate,
                isCheck: isCheck,
                debtSum: debtSum,
                orderSum: orderSum,
                paidSum: paidSum,
                paymentSum: paymentSum,
                physical: physical,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $DebtsTable,
      Debt,
      $$DebtsTableFilterComposer,
      $$DebtsTableOrderingComposer,
      $$DebtsTableAnnotationComposer,
      $$DebtsTableCreateCompanionBuilder,
      $$DebtsTableUpdateCompanionBuilder,
      (Debt, BaseReferences<_$AppDataStore, $DebtsTable, Debt>),
      Debt,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required int buyerId,
      required int deliveryId,
      required int ord,
      required String ndoc,
      required String info,
      required bool isInc,
      required int goodsCnt,
      required double mc,
      Value<bool?> delivered,
      required bool paid,
      required bool physical,
      required bool needScan,
      required bool dovUnload,
      Value<String?> address,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<int> buyerId,
      Value<int> deliveryId,
      Value<int> ord,
      Value<String> ndoc,
      Value<String> info,
      Value<bool> isInc,
      Value<int> goodsCnt,
      Value<double> mc,
      Value<bool?> delivered,
      Value<bool> paid,
      Value<bool> physical,
      Value<bool> needScan,
      Value<bool> dovUnload,
      Value<String?> address,
    });

class $$OrdersTableFilterComposer
    extends Composer<_$AppDataStore, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInc => $composableBuilder(
    column: $table.isInc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goodsCnt => $composableBuilder(
    column: $table.goodsCnt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mc => $composableBuilder(
    column: $table.mc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get delivered => $composableBuilder(
    column: $table.delivered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get physical => $composableBuilder(
    column: $table.physical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needScan => $composableBuilder(
    column: $table.needScan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dovUnload => $composableBuilder(
    column: $table.dovUnload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDataStore, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInc => $composableBuilder(
    column: $table.isInc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goodsCnt => $composableBuilder(
    column: $table.goodsCnt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mc => $composableBuilder(
    column: $table.mc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get delivered => $composableBuilder(
    column: $table.delivered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get physical => $composableBuilder(
    column: $table.physical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needScan => $composableBuilder(
    column: $table.needScan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dovUnload => $composableBuilder(
    column: $table.dovUnload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDataStore, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ord =>
      $composableBuilder(column: $table.ord, builder: (column) => column);

  GeneratedColumn<String> get ndoc =>
      $composableBuilder(column: $table.ndoc, builder: (column) => column);

  GeneratedColumn<String> get info =>
      $composableBuilder(column: $table.info, builder: (column) => column);

  GeneratedColumn<bool> get isInc =>
      $composableBuilder(column: $table.isInc, builder: (column) => column);

  GeneratedColumn<int> get goodsCnt =>
      $composableBuilder(column: $table.goodsCnt, builder: (column) => column);

  GeneratedColumn<double> get mc =>
      $composableBuilder(column: $table.mc, builder: (column) => column);

  GeneratedColumn<bool> get delivered =>
      $composableBuilder(column: $table.delivered, builder: (column) => column);

  GeneratedColumn<bool> get paid =>
      $composableBuilder(column: $table.paid, builder: (column) => column);

  GeneratedColumn<bool> get physical =>
      $composableBuilder(column: $table.physical, builder: (column) => column);

  GeneratedColumn<bool> get needScan =>
      $composableBuilder(column: $table.needScan, builder: (column) => column);

  GeneratedColumn<bool> get dovUnload =>
      $composableBuilder(column: $table.dovUnload, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, BaseReferences<_$AppDataStore, $OrdersTable, Order>),
          Order,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDataStore db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> deliveryId = const Value.absent(),
                Value<int> ord = const Value.absent(),
                Value<String> ndoc = const Value.absent(),
                Value<String> info = const Value.absent(),
                Value<bool> isInc = const Value.absent(),
                Value<int> goodsCnt = const Value.absent(),
                Value<double> mc = const Value.absent(),
                Value<bool?> delivered = const Value.absent(),
                Value<bool> paid = const Value.absent(),
                Value<bool> physical = const Value.absent(),
                Value<bool> needScan = const Value.absent(),
                Value<bool> dovUnload = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                ord: ord,
                ndoc: ndoc,
                info: info,
                isInc: isInc,
                goodsCnt: goodsCnt,
                mc: mc,
                delivered: delivered,
                paid: paid,
                physical: physical,
                needScan: needScan,
                dovUnload: dovUnload,
                address: address,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buyerId,
                required int deliveryId,
                required int ord,
                required String ndoc,
                required String info,
                required bool isInc,
                required int goodsCnt,
                required double mc,
                Value<bool?> delivered = const Value.absent(),
                required bool paid,
                required bool physical,
                required bool needScan,
                required bool dovUnload,
                Value<String?> address = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                ord: ord,
                ndoc: ndoc,
                info: info,
                isInc: isInc,
                goodsCnt: goodsCnt,
                mc: mc,
                delivered: delivered,
                paid: paid,
                physical: physical,
                needScan: needScan,
                dovUnload: dovUnload,
                address: address,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, BaseReferences<_$AppDataStore, $OrdersTable, Order>),
      Order,
      PrefetchHooks Function()
    >;
typedef $$OrderLinesTableCreateCompanionBuilder =
    OrderLinesCompanion Function({
      required int orderId,
      required int subid,
      required String name,
      required String gtin,
      required double vol,
      required double deliveredVol,
      required double price,
      required bool needMarking,
      required int minMeasureId,
      required List<OrderLineBarcode> barcodeRels,
      Value<int> rowid,
    });
typedef $$OrderLinesTableUpdateCompanionBuilder =
    OrderLinesCompanion Function({
      Value<int> orderId,
      Value<int> subid,
      Value<String> name,
      Value<String> gtin,
      Value<double> vol,
      Value<double> deliveredVol,
      Value<double> price,
      Value<bool> needMarking,
      Value<int> minMeasureId,
      Value<List<OrderLineBarcode>> barcodeRels,
      Value<int> rowid,
    });

class $$OrderLinesTableFilterComposer
    extends Composer<_$AppDataStore, $OrderLinesTable> {
  $$OrderLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gtin => $composableBuilder(
    column: $table.gtin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vol => $composableBuilder(
    column: $table.vol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deliveredVol => $composableBuilder(
    column: $table.deliveredVol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needMarking => $composableBuilder(
    column: $table.needMarking,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minMeasureId => $composableBuilder(
    column: $table.minMeasureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<OrderLineBarcode>,
    List<OrderLineBarcode>,
    String
  >
  get barcodeRels => $composableBuilder(
    column: $table.barcodeRels,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$OrderLinesTableOrderingComposer
    extends Composer<_$AppDataStore, $OrderLinesTable> {
  $$OrderLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gtin => $composableBuilder(
    column: $table.gtin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vol => $composableBuilder(
    column: $table.vol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deliveredVol => $composableBuilder(
    column: $table.deliveredVol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needMarking => $composableBuilder(
    column: $table.needMarking,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minMeasureId => $composableBuilder(
    column: $table.minMeasureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcodeRels => $composableBuilder(
    column: $table.barcodeRels,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderLinesTableAnnotationComposer
    extends Composer<_$AppDataStore, $OrderLinesTable> {
  $$OrderLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get subid =>
      $composableBuilder(column: $table.subid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gtin =>
      $composableBuilder(column: $table.gtin, builder: (column) => column);

  GeneratedColumn<double> get vol =>
      $composableBuilder(column: $table.vol, builder: (column) => column);

  GeneratedColumn<double> get deliveredVol => $composableBuilder(
    column: $table.deliveredVol,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<bool> get needMarking => $composableBuilder(
    column: $table.needMarking,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minMeasureId => $composableBuilder(
    column: $table.minMeasureId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<OrderLineBarcode>, String>
  get barcodeRels => $composableBuilder(
    column: $table.barcodeRels,
    builder: (column) => column,
  );
}

class $$OrderLinesTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $OrderLinesTable,
          OrderLine,
          $$OrderLinesTableFilterComposer,
          $$OrderLinesTableOrderingComposer,
          $$OrderLinesTableAnnotationComposer,
          $$OrderLinesTableCreateCompanionBuilder,
          $$OrderLinesTableUpdateCompanionBuilder,
          (
            OrderLine,
            BaseReferences<_$AppDataStore, $OrderLinesTable, OrderLine>,
          ),
          OrderLine,
          PrefetchHooks Function()
        > {
  $$OrderLinesTableTableManager(_$AppDataStore db, $OrderLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrderLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$OrderLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$OrderLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                Value<int> subid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> gtin = const Value.absent(),
                Value<double> vol = const Value.absent(),
                Value<double> deliveredVol = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<bool> needMarking = const Value.absent(),
                Value<int> minMeasureId = const Value.absent(),
                Value<List<OrderLineBarcode>> barcodeRels =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderLinesCompanion(
                orderId: orderId,
                subid: subid,
                name: name,
                gtin: gtin,
                vol: vol,
                deliveredVol: deliveredVol,
                price: price,
                needMarking: needMarking,
                minMeasureId: minMeasureId,
                barcodeRels: barcodeRels,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int orderId,
                required int subid,
                required String name,
                required String gtin,
                required double vol,
                required double deliveredVol,
                required double price,
                required bool needMarking,
                required int minMeasureId,
                required List<OrderLineBarcode> barcodeRels,
                Value<int> rowid = const Value.absent(),
              }) => OrderLinesCompanion.insert(
                orderId: orderId,
                subid: subid,
                name: name,
                gtin: gtin,
                vol: vol,
                deliveredVol: deliveredVol,
                price: price,
                needMarking: needMarking,
                minMeasureId: minMeasureId,
                barcodeRels: barcodeRels,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrderLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $OrderLinesTable,
      OrderLine,
      $$OrderLinesTableFilterComposer,
      $$OrderLinesTableOrderingComposer,
      $$OrderLinesTableAnnotationComposer,
      $$OrderLinesTableCreateCompanionBuilder,
      $$OrderLinesTableUpdateCompanionBuilder,
      (OrderLine, BaseReferences<_$AppDataStore, $OrderLinesTable, OrderLine>),
      OrderLine,
      PrefetchHooks Function()
    >;
typedef $$OrderLineCodesTableCreateCompanionBuilder =
    OrderLineCodesCompanion Function({
      Value<int?> id,
      required int orderId,
      required int subid,
      required String code,
      required int amount,
      required bool isDataMatrix,
      Value<String?> groupCode,
      required DateTime localTs,
      Value<int> rowid,
    });
typedef $$OrderLineCodesTableUpdateCompanionBuilder =
    OrderLineCodesCompanion Function({
      Value<int?> id,
      Value<int> orderId,
      Value<int> subid,
      Value<String> code,
      Value<int> amount,
      Value<bool> isDataMatrix,
      Value<String?> groupCode,
      Value<DateTime> localTs,
      Value<int> rowid,
    });

class $$OrderLineCodesTableFilterComposer
    extends Composer<_$AppDataStore, $OrderLineCodesTable> {
  $$OrderLineCodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDataMatrix => $composableBuilder(
    column: $table.isDataMatrix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localTs => $composableBuilder(
    column: $table.localTs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrderLineCodesTableOrderingComposer
    extends Composer<_$AppDataStore, $OrderLineCodesTable> {
  $$OrderLineCodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDataMatrix => $composableBuilder(
    column: $table.isDataMatrix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localTs => $composableBuilder(
    column: $table.localTs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderLineCodesTableAnnotationComposer
    extends Composer<_$AppDataStore, $OrderLineCodesTable> {
  $$OrderLineCodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get subid =>
      $composableBuilder(column: $table.subid, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get isDataMatrix => $composableBuilder(
    column: $table.isDataMatrix,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupCode =>
      $composableBuilder(column: $table.groupCode, builder: (column) => column);

  GeneratedColumn<DateTime> get localTs =>
      $composableBuilder(column: $table.localTs, builder: (column) => column);
}

class $$OrderLineCodesTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $OrderLineCodesTable,
          OrderLineCode,
          $$OrderLineCodesTableFilterComposer,
          $$OrderLineCodesTableOrderingComposer,
          $$OrderLineCodesTableAnnotationComposer,
          $$OrderLineCodesTableCreateCompanionBuilder,
          $$OrderLineCodesTableUpdateCompanionBuilder,
          (
            OrderLineCode,
            BaseReferences<_$AppDataStore, $OrderLineCodesTable, OrderLineCode>,
          ),
          OrderLineCode,
          PrefetchHooks Function()
        > {
  $$OrderLineCodesTableTableManager(
    _$AppDataStore db,
    $OrderLineCodesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrderLineCodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$OrderLineCodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$OrderLineCodesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> subid = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<bool> isDataMatrix = const Value.absent(),
                Value<String?> groupCode = const Value.absent(),
                Value<DateTime> localTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderLineCodesCompanion(
                id: id,
                orderId: orderId,
                subid: subid,
                code: code,
                amount: amount,
                isDataMatrix: isDataMatrix,
                groupCode: groupCode,
                localTs: localTs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required int orderId,
                required int subid,
                required String code,
                required int amount,
                required bool isDataMatrix,
                Value<String?> groupCode = const Value.absent(),
                required DateTime localTs,
                Value<int> rowid = const Value.absent(),
              }) => OrderLineCodesCompanion.insert(
                id: id,
                orderId: orderId,
                subid: subid,
                code: code,
                amount: amount,
                isDataMatrix: isDataMatrix,
                groupCode: groupCode,
                localTs: localTs,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrderLineCodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $OrderLineCodesTable,
      OrderLineCode,
      $$OrderLineCodesTableFilterComposer,
      $$OrderLineCodesTableOrderingComposer,
      $$OrderLineCodesTableAnnotationComposer,
      $$OrderLineCodesTableCreateCompanionBuilder,
      $$OrderLineCodesTableUpdateCompanionBuilder,
      (
        OrderLineCode,
        BaseReferences<_$AppDataStore, $OrderLineCodesTable, OrderLineCode>,
      ),
      OrderLineCode,
      PrefetchHooks Function()
    >;
typedef $$OrderLineStorageCodesTableCreateCompanionBuilder =
    OrderLineStorageCodesCompanion Function({
      required int orderId,
      required int subid,
      required String code,
      Value<String?> groupCode,
      required int amount,
      Value<int> rowid,
    });
typedef $$OrderLineStorageCodesTableUpdateCompanionBuilder =
    OrderLineStorageCodesCompanion Function({
      Value<int> orderId,
      Value<int> subid,
      Value<String> code,
      Value<String?> groupCode,
      Value<int> amount,
      Value<int> rowid,
    });

class $$OrderLineStorageCodesTableFilterComposer
    extends Composer<_$AppDataStore, $OrderLineStorageCodesTable> {
  $$OrderLineStorageCodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrderLineStorageCodesTableOrderingComposer
    extends Composer<_$AppDataStore, $OrderLineStorageCodesTable> {
  $$OrderLineStorageCodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderLineStorageCodesTableAnnotationComposer
    extends Composer<_$AppDataStore, $OrderLineStorageCodesTable> {
  $$OrderLineStorageCodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get subid =>
      $composableBuilder(column: $table.subid, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get groupCode =>
      $composableBuilder(column: $table.groupCode, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$OrderLineStorageCodesTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $OrderLineStorageCodesTable,
          OrderLineStorageCode,
          $$OrderLineStorageCodesTableFilterComposer,
          $$OrderLineStorageCodesTableOrderingComposer,
          $$OrderLineStorageCodesTableAnnotationComposer,
          $$OrderLineStorageCodesTableCreateCompanionBuilder,
          $$OrderLineStorageCodesTableUpdateCompanionBuilder,
          (
            OrderLineStorageCode,
            BaseReferences<
              _$AppDataStore,
              $OrderLineStorageCodesTable,
              OrderLineStorageCode
            >,
          ),
          OrderLineStorageCode,
          PrefetchHooks Function()
        > {
  $$OrderLineStorageCodesTableTableManager(
    _$AppDataStore db,
    $OrderLineStorageCodesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrderLineStorageCodesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$OrderLineStorageCodesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$OrderLineStorageCodesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                Value<int> subid = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> groupCode = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderLineStorageCodesCompanion(
                orderId: orderId,
                subid: subid,
                code: code,
                groupCode: groupCode,
                amount: amount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int orderId,
                required int subid,
                required String code,
                Value<String?> groupCode = const Value.absent(),
                required int amount,
                Value<int> rowid = const Value.absent(),
              }) => OrderLineStorageCodesCompanion.insert(
                orderId: orderId,
                subid: subid,
                code: code,
                groupCode: groupCode,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrderLineStorageCodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $OrderLineStorageCodesTable,
      OrderLineStorageCode,
      $$OrderLineStorageCodesTableFilterComposer,
      $$OrderLineStorageCodesTableOrderingComposer,
      $$OrderLineStorageCodesTableAnnotationComposer,
      $$OrderLineStorageCodesTableCreateCompanionBuilder,
      $$OrderLineStorageCodesTableUpdateCompanionBuilder,
      (
        OrderLineStorageCode,
        BaseReferences<
          _$AppDataStore,
          $OrderLineStorageCodesTable,
          OrderLineStorageCode
        >,
      ),
      OrderLineStorageCode,
      PrefetchHooks Function()
    >;
typedef $$OrderLinePackErrorsTableCreateCompanionBuilder =
    OrderLinePackErrorsCompanion Function({
      Value<int?> id,
      required int orderId,
      required int subid,
      required int measureId,
      required double volume,
      Value<String?> groupCode,
      required DateTime localTs,
      Value<int> rowid,
    });
typedef $$OrderLinePackErrorsTableUpdateCompanionBuilder =
    OrderLinePackErrorsCompanion Function({
      Value<int?> id,
      Value<int> orderId,
      Value<int> subid,
      Value<int> measureId,
      Value<double> volume,
      Value<String?> groupCode,
      Value<DateTime> localTs,
      Value<int> rowid,
    });

class $$OrderLinePackErrorsTableFilterComposer
    extends Composer<_$AppDataStore, $OrderLinePackErrorsTable> {
  $$OrderLinePackErrorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get measureId => $composableBuilder(
    column: $table.measureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localTs => $composableBuilder(
    column: $table.localTs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrderLinePackErrorsTableOrderingComposer
    extends Composer<_$AppDataStore, $OrderLinePackErrorsTable> {
  $$OrderLinePackErrorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subid => $composableBuilder(
    column: $table.subid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get measureId => $composableBuilder(
    column: $table.measureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localTs => $composableBuilder(
    column: $table.localTs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderLinePackErrorsTableAnnotationComposer
    extends Composer<_$AppDataStore, $OrderLinePackErrorsTable> {
  $$OrderLinePackErrorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get subid =>
      $composableBuilder(column: $table.subid, builder: (column) => column);

  GeneratedColumn<int> get measureId =>
      $composableBuilder(column: $table.measureId, builder: (column) => column);

  GeneratedColumn<double> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumn<String> get groupCode =>
      $composableBuilder(column: $table.groupCode, builder: (column) => column);

  GeneratedColumn<DateTime> get localTs =>
      $composableBuilder(column: $table.localTs, builder: (column) => column);
}

class $$OrderLinePackErrorsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $OrderLinePackErrorsTable,
          OrderLinePackError,
          $$OrderLinePackErrorsTableFilterComposer,
          $$OrderLinePackErrorsTableOrderingComposer,
          $$OrderLinePackErrorsTableAnnotationComposer,
          $$OrderLinePackErrorsTableCreateCompanionBuilder,
          $$OrderLinePackErrorsTableUpdateCompanionBuilder,
          (
            OrderLinePackError,
            BaseReferences<
              _$AppDataStore,
              $OrderLinePackErrorsTable,
              OrderLinePackError
            >,
          ),
          OrderLinePackError,
          PrefetchHooks Function()
        > {
  $$OrderLinePackErrorsTableTableManager(
    _$AppDataStore db,
    $OrderLinePackErrorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrderLinePackErrorsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$OrderLinePackErrorsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$OrderLinePackErrorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> subid = const Value.absent(),
                Value<int> measureId = const Value.absent(),
                Value<double> volume = const Value.absent(),
                Value<String?> groupCode = const Value.absent(),
                Value<DateTime> localTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderLinePackErrorsCompanion(
                id: id,
                orderId: orderId,
                subid: subid,
                measureId: measureId,
                volume: volume,
                groupCode: groupCode,
                localTs: localTs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required int orderId,
                required int subid,
                required int measureId,
                required double volume,
                Value<String?> groupCode = const Value.absent(),
                required DateTime localTs,
                Value<int> rowid = const Value.absent(),
              }) => OrderLinePackErrorsCompanion.insert(
                id: id,
                orderId: orderId,
                subid: subid,
                measureId: measureId,
                volume: volume,
                groupCode: groupCode,
                localTs: localTs,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrderLinePackErrorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $OrderLinePackErrorsTable,
      OrderLinePackError,
      $$OrderLinePackErrorsTableFilterComposer,
      $$OrderLinePackErrorsTableOrderingComposer,
      $$OrderLinePackErrorsTableAnnotationComposer,
      $$OrderLinePackErrorsTableCreateCompanionBuilder,
      $$OrderLinePackErrorsTableUpdateCompanionBuilder,
      (
        OrderLinePackError,
        BaseReferences<
          _$AppDataStore,
          $OrderLinePackErrorsTable,
          OrderLinePackError
        >,
      ),
      OrderLinePackError,
      PrefetchHooks Function()
    >;
typedef $$BuyerDeliveryMarksTableCreateCompanionBuilder =
    BuyerDeliveryMarksCompanion Function({
      Value<int?> id,
      required int buyerId,
      required int deliveryId,
      required BuyerDeliveryMarkType type,
      required double latitude,
      required double longitude,
      required double accuracy,
      required double altitude,
      required double heading,
      required double speed,
      required DateTime pointTs,
      Value<int> rowid,
    });
typedef $$BuyerDeliveryMarksTableUpdateCompanionBuilder =
    BuyerDeliveryMarksCompanion Function({
      Value<int?> id,
      Value<int> buyerId,
      Value<int> deliveryId,
      Value<BuyerDeliveryMarkType> type,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> accuracy,
      Value<double> altitude,
      Value<double> heading,
      Value<double> speed,
      Value<DateTime> pointTs,
      Value<int> rowid,
    });

class $$BuyerDeliveryMarksTableFilterComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryMarksTable> {
  $$BuyerDeliveryMarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    BuyerDeliveryMarkType,
    BuyerDeliveryMarkType,
    String
  >
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heading => $composableBuilder(
    column: $table.heading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get pointTs => $composableBuilder(
    column: $table.pointTs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuyerDeliveryMarksTableOrderingComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryMarksTable> {
  $$BuyerDeliveryMarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heading => $composableBuilder(
    column: $table.heading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get pointTs => $composableBuilder(
    column: $table.pointTs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuyerDeliveryMarksTableAnnotationComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryMarksTable> {
  $$BuyerDeliveryMarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BuyerDeliveryMarkType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get heading =>
      $composableBuilder(column: $table.heading, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<DateTime> get pointTs =>
      $composableBuilder(column: $table.pointTs, builder: (column) => column);
}

class $$BuyerDeliveryMarksTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $BuyerDeliveryMarksTable,
          BuyerDeliveryMark,
          $$BuyerDeliveryMarksTableFilterComposer,
          $$BuyerDeliveryMarksTableOrderingComposer,
          $$BuyerDeliveryMarksTableAnnotationComposer,
          $$BuyerDeliveryMarksTableCreateCompanionBuilder,
          $$BuyerDeliveryMarksTableUpdateCompanionBuilder,
          (
            BuyerDeliveryMark,
            BaseReferences<
              _$AppDataStore,
              $BuyerDeliveryMarksTable,
              BuyerDeliveryMark
            >,
          ),
          BuyerDeliveryMark,
          PrefetchHooks Function()
        > {
  $$BuyerDeliveryMarksTableTableManager(
    _$AppDataStore db,
    $BuyerDeliveryMarksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BuyerDeliveryMarksTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$BuyerDeliveryMarksTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BuyerDeliveryMarksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> deliveryId = const Value.absent(),
                Value<BuyerDeliveryMarkType> type = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> accuracy = const Value.absent(),
                Value<double> altitude = const Value.absent(),
                Value<double> heading = const Value.absent(),
                Value<double> speed = const Value.absent(),
                Value<DateTime> pointTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuyerDeliveryMarksCompanion(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                type: type,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                heading: heading,
                speed: speed,
                pointTs: pointTs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required int buyerId,
                required int deliveryId,
                required BuyerDeliveryMarkType type,
                required double latitude,
                required double longitude,
                required double accuracy,
                required double altitude,
                required double heading,
                required double speed,
                required DateTime pointTs,
                Value<int> rowid = const Value.absent(),
              }) => BuyerDeliveryMarksCompanion.insert(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                type: type,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                heading: heading,
                speed: speed,
                pointTs: pointTs,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuyerDeliveryMarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $BuyerDeliveryMarksTable,
      BuyerDeliveryMark,
      $$BuyerDeliveryMarksTableFilterComposer,
      $$BuyerDeliveryMarksTableOrderingComposer,
      $$BuyerDeliveryMarksTableAnnotationComposer,
      $$BuyerDeliveryMarksTableCreateCompanionBuilder,
      $$BuyerDeliveryMarksTableUpdateCompanionBuilder,
      (
        BuyerDeliveryMark,
        BaseReferences<
          _$AppDataStore,
          $BuyerDeliveryMarksTable,
          BuyerDeliveryMark
        >,
      ),
      BuyerDeliveryMark,
      PrefetchHooks Function()
    >;
typedef $$BuyerDeliveryPointsTableCreateCompanionBuilder =
    BuyerDeliveryPointsCompanion Function({
      Value<bool> isDeleted,
      Value<DateTime> timestamp,
      Value<DateTime?> lastSyncTime,
      Value<int> id,
      required int buyerId,
      Value<String?> phone,
      Value<String?> info,
    });
typedef $$BuyerDeliveryPointsTableUpdateCompanionBuilder =
    BuyerDeliveryPointsCompanion Function({
      Value<bool> isDeleted,
      Value<DateTime> timestamp,
      Value<DateTime?> lastSyncTime,
      Value<int> id,
      Value<int> buyerId,
      Value<String?> phone,
      Value<String?> info,
    });

class $$BuyerDeliveryPointsTableFilterComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointsTable> {
  $$BuyerDeliveryPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needSync => $composableBuilder(
    column: $table.needSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuyerDeliveryPointsTableOrderingComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointsTable> {
  $$BuyerDeliveryPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needSync => $composableBuilder(
    column: $table.needSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuyerDeliveryPointsTableAnnotationComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointsTable> {
  $$BuyerDeliveryPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needSync =>
      $composableBuilder(column: $table.needSync, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get info =>
      $composableBuilder(column: $table.info, builder: (column) => column);
}

class $$BuyerDeliveryPointsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $BuyerDeliveryPointsTable,
          BuyerDeliveryPoint,
          $$BuyerDeliveryPointsTableFilterComposer,
          $$BuyerDeliveryPointsTableOrderingComposer,
          $$BuyerDeliveryPointsTableAnnotationComposer,
          $$BuyerDeliveryPointsTableCreateCompanionBuilder,
          $$BuyerDeliveryPointsTableUpdateCompanionBuilder,
          (
            BuyerDeliveryPoint,
            BaseReferences<
              _$AppDataStore,
              $BuyerDeliveryPointsTable,
              BuyerDeliveryPoint
            >,
          ),
          BuyerDeliveryPoint,
          PrefetchHooks Function()
        > {
  $$BuyerDeliveryPointsTableTableManager(
    _$AppDataStore db,
    $BuyerDeliveryPointsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BuyerDeliveryPointsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$BuyerDeliveryPointsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BuyerDeliveryPointsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> info = const Value.absent(),
              }) => BuyerDeliveryPointsCompanion(
                isDeleted: isDeleted,
                timestamp: timestamp,
                lastSyncTime: lastSyncTime,
                id: id,
                buyerId: buyerId,
                phone: phone,
                info: info,
              ),
          createCompanionCallback:
              ({
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int buyerId,
                Value<String?> phone = const Value.absent(),
                Value<String?> info = const Value.absent(),
              }) => BuyerDeliveryPointsCompanion.insert(
                isDeleted: isDeleted,
                timestamp: timestamp,
                lastSyncTime: lastSyncTime,
                id: id,
                buyerId: buyerId,
                phone: phone,
                info: info,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuyerDeliveryPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $BuyerDeliveryPointsTable,
      BuyerDeliveryPoint,
      $$BuyerDeliveryPointsTableFilterComposer,
      $$BuyerDeliveryPointsTableOrderingComposer,
      $$BuyerDeliveryPointsTableAnnotationComposer,
      $$BuyerDeliveryPointsTableCreateCompanionBuilder,
      $$BuyerDeliveryPointsTableUpdateCompanionBuilder,
      (
        BuyerDeliveryPoint,
        BaseReferences<
          _$AppDataStore,
          $BuyerDeliveryPointsTable,
          BuyerDeliveryPoint
        >,
      ),
      BuyerDeliveryPoint,
      PrefetchHooks Function()
    >;
typedef $$BuyerDeliveryPointPhotosTableCreateCompanionBuilder =
    BuyerDeliveryPointPhotosCompanion Function({
      Value<bool> isDeleted,
      Value<DateTime> timestamp,
      Value<DateTime?> lastSyncTime,
      Value<int> id,
      required int buyerDeliveryPointId,
      required String url,
      required String key,
    });
typedef $$BuyerDeliveryPointPhotosTableUpdateCompanionBuilder =
    BuyerDeliveryPointPhotosCompanion Function({
      Value<bool> isDeleted,
      Value<DateTime> timestamp,
      Value<DateTime?> lastSyncTime,
      Value<int> id,
      Value<int> buyerDeliveryPointId,
      Value<String> url,
      Value<String> key,
    });

class $$BuyerDeliveryPointPhotosTableFilterComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointPhotosTable> {
  $$BuyerDeliveryPointPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needSync => $composableBuilder(
    column: $table.needSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerDeliveryPointId => $composableBuilder(
    column: $table.buyerDeliveryPointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuyerDeliveryPointPhotosTableOrderingComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointPhotosTable> {
  $$BuyerDeliveryPointPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needSync => $composableBuilder(
    column: $table.needSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerDeliveryPointId => $composableBuilder(
    column: $table.buyerDeliveryPointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuyerDeliveryPointPhotosTableAnnotationComposer
    extends Composer<_$AppDataStore, $BuyerDeliveryPointPhotosTable> {
  $$BuyerDeliveryPointPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needSync =>
      $composableBuilder(column: $table.needSync, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerDeliveryPointId => $composableBuilder(
    column: $table.buyerDeliveryPointId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);
}

class $$BuyerDeliveryPointPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $BuyerDeliveryPointPhotosTable,
          BuyerDeliveryPointPhoto,
          $$BuyerDeliveryPointPhotosTableFilterComposer,
          $$BuyerDeliveryPointPhotosTableOrderingComposer,
          $$BuyerDeliveryPointPhotosTableAnnotationComposer,
          $$BuyerDeliveryPointPhotosTableCreateCompanionBuilder,
          $$BuyerDeliveryPointPhotosTableUpdateCompanionBuilder,
          (
            BuyerDeliveryPointPhoto,
            BaseReferences<
              _$AppDataStore,
              $BuyerDeliveryPointPhotosTable,
              BuyerDeliveryPointPhoto
            >,
          ),
          BuyerDeliveryPointPhoto,
          PrefetchHooks Function()
        > {
  $$BuyerDeliveryPointPhotosTableTableManager(
    _$AppDataStore db,
    $BuyerDeliveryPointPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BuyerDeliveryPointPhotosTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$BuyerDeliveryPointPhotosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BuyerDeliveryPointPhotosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> buyerDeliveryPointId = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> key = const Value.absent(),
              }) => BuyerDeliveryPointPhotosCompanion(
                isDeleted: isDeleted,
                timestamp: timestamp,
                lastSyncTime: lastSyncTime,
                id: id,
                buyerDeliveryPointId: buyerDeliveryPointId,
                url: url,
                key: key,
              ),
          createCompanionCallback:
              ({
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int buyerDeliveryPointId,
                required String url,
                required String key,
              }) => BuyerDeliveryPointPhotosCompanion.insert(
                isDeleted: isDeleted,
                timestamp: timestamp,
                lastSyncTime: lastSyncTime,
                id: id,
                buyerDeliveryPointId: buyerDeliveryPointId,
                url: url,
                key: key,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuyerDeliveryPointPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $BuyerDeliveryPointPhotosTable,
      BuyerDeliveryPointPhoto,
      $$BuyerDeliveryPointPhotosTableFilterComposer,
      $$BuyerDeliveryPointPhotosTableOrderingComposer,
      $$BuyerDeliveryPointPhotosTableAnnotationComposer,
      $$BuyerDeliveryPointPhotosTableCreateCompanionBuilder,
      $$BuyerDeliveryPointPhotosTableUpdateCompanionBuilder,
      (
        BuyerDeliveryPointPhoto,
        BaseReferences<
          _$AppDataStore,
          $BuyerDeliveryPointPhotosTable,
          BuyerDeliveryPointPhoto
        >,
      ),
      BuyerDeliveryPointPhoto,
      PrefetchHooks Function()
    >;
typedef $$PrefsTableCreateCompanionBuilder =
    PrefsCompanion Function({Value<DateTime?> lastLoadTime, Value<int> rowid});
typedef $$PrefsTableUpdateCompanionBuilder =
    PrefsCompanion Function({Value<DateTime?> lastLoadTime, Value<int> rowid});

class $$PrefsTableFilterComposer extends Composer<_$AppDataStore, $PrefsTable> {
  $$PrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get lastLoadTime => $composableBuilder(
    column: $table.lastLoadTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrefsTableOrderingComposer
    extends Composer<_$AppDataStore, $PrefsTable> {
  $$PrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get lastLoadTime => $composableBuilder(
    column: $table.lastLoadTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrefsTableAnnotationComposer
    extends Composer<_$AppDataStore, $PrefsTable> {
  $$PrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get lastLoadTime => $composableBuilder(
    column: $table.lastLoadTime,
    builder: (column) => column,
  );
}

class $$PrefsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $PrefsTable,
          Pref,
          $$PrefsTableFilterComposer,
          $$PrefsTableOrderingComposer,
          $$PrefsTableAnnotationComposer,
          $$PrefsTableCreateCompanionBuilder,
          $$PrefsTableUpdateCompanionBuilder,
          (Pref, BaseReferences<_$AppDataStore, $PrefsTable, Pref>),
          Pref,
          PrefetchHooks Function()
        > {
  $$PrefsTableTableManager(_$AppDataStore db, $PrefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> lastLoadTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrefsCompanion(lastLoadTime: lastLoadTime, rowid: rowid),
          createCompanionCallback:
              ({
                Value<DateTime?> lastLoadTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrefsCompanion.insert(
                lastLoadTime: lastLoadTime,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $PrefsTable,
      Pref,
      $$PrefsTableFilterComposer,
      $$PrefsTableOrderingComposer,
      $$PrefsTableAnnotationComposer,
      $$PrefsTableCreateCompanionBuilder,
      $$PrefsTableUpdateCompanionBuilder,
      (Pref, BaseReferences<_$AppDataStore, $PrefsTable, Pref>),
      Pref,
      PrefetchHooks Function()
    >;
typedef $$DeliveriesTableCreateCompanionBuilder =
    DeliveriesCompanion Function({
      Value<int> id,
      required String ndoc,
      Value<DateTime?> ddateb,
    });
typedef $$DeliveriesTableUpdateCompanionBuilder =
    DeliveriesCompanion Function({
      Value<int> id,
      Value<String> ndoc,
      Value<DateTime?> ddateb,
    });

class $$DeliveriesTableFilterComposer
    extends Composer<_$AppDataStore, $DeliveriesTable> {
  $$DeliveriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ddateb => $composableBuilder(
    column: $table.ddateb,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeliveriesTableOrderingComposer
    extends Composer<_$AppDataStore, $DeliveriesTable> {
  $$DeliveriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ndoc => $composableBuilder(
    column: $table.ndoc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ddateb => $composableBuilder(
    column: $table.ddateb,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeliveriesTableAnnotationComposer
    extends Composer<_$AppDataStore, $DeliveriesTable> {
  $$DeliveriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ndoc =>
      $composableBuilder(column: $table.ndoc, builder: (column) => column);

  GeneratedColumn<DateTime> get ddateb =>
      $composableBuilder(column: $table.ddateb, builder: (column) => column);
}

class $$DeliveriesTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $DeliveriesTable,
          Delivery,
          $$DeliveriesTableFilterComposer,
          $$DeliveriesTableOrderingComposer,
          $$DeliveriesTableAnnotationComposer,
          $$DeliveriesTableCreateCompanionBuilder,
          $$DeliveriesTableUpdateCompanionBuilder,
          (
            Delivery,
            BaseReferences<_$AppDataStore, $DeliveriesTable, Delivery>,
          ),
          Delivery,
          PrefetchHooks Function()
        > {
  $$DeliveriesTableTableManager(_$AppDataStore db, $DeliveriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DeliveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DeliveriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DeliveriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ndoc = const Value.absent(),
                Value<DateTime?> ddateb = const Value.absent(),
              }) => DeliveriesCompanion(id: id, ndoc: ndoc, ddateb: ddateb),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ndoc,
                Value<DateTime?> ddateb = const Value.absent(),
              }) => DeliveriesCompanion.insert(
                id: id,
                ndoc: ndoc,
                ddateb: ddateb,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeliveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $DeliveriesTable,
      Delivery,
      $$DeliveriesTableFilterComposer,
      $$DeliveriesTableOrderingComposer,
      $$DeliveriesTableAnnotationComposer,
      $$DeliveriesTableCreateCompanionBuilder,
      $$DeliveriesTableUpdateCompanionBuilder,
      (Delivery, BaseReferences<_$AppDataStore, $DeliveriesTable, Delivery>),
      Delivery,
      PrefetchHooks Function()
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required int buyerId,
      required int deliveryId,
      required String taskTypeName,
      required String taskNumber,
      Value<String?> info,
      Value<bool?> completed,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<int> buyerId,
      Value<int> deliveryId,
      Value<String> taskTypeName,
      Value<String> taskNumber,
      Value<String?> info,
      Value<bool?> completed,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDataStore, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskTypeName => $composableBuilder(
    column: $table.taskTypeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskNumber => $composableBuilder(
    column: $table.taskNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDataStore, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyerId => $composableBuilder(
    column: $table.buyerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskTypeName => $composableBuilder(
    column: $table.taskTypeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskNumber => $composableBuilder(
    column: $table.taskNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get info => $composableBuilder(
    column: $table.info,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDataStore, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get buyerId =>
      $composableBuilder(column: $table.buyerId, builder: (column) => column);

  GeneratedColumn<int> get deliveryId => $composableBuilder(
    column: $table.deliveryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskTypeName => $composableBuilder(
    column: $table.taskTypeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskNumber => $composableBuilder(
    column: $table.taskNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get info =>
      $composableBuilder(column: $table.info, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDataStore, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDataStore db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> deliveryId = const Value.absent(),
                Value<String> taskTypeName = const Value.absent(),
                Value<String> taskNumber = const Value.absent(),
                Value<String?> info = const Value.absent(),
                Value<bool?> completed = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                taskTypeName: taskTypeName,
                taskNumber: taskNumber,
                info: info,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buyerId,
                required int deliveryId,
                required String taskTypeName,
                required String taskNumber,
                Value<String?> info = const Value.absent(),
                Value<bool?> completed = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                buyerId: buyerId,
                deliveryId: deliveryId,
                taskTypeName: taskTypeName,
                taskNumber: taskNumber,
                info: info,
                completed: completed,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDataStore, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;

class $AppDataStoreManager {
  final _$AppDataStore _db;
  $AppDataStoreManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ReceptsTableTableManager get recepts =>
      $$ReceptsTableTableManager(_db, _db.recepts);
  $$IncomesTableTableManager get incomes =>
      $$IncomesTableTableManager(_db, _db.incomes);
  $$BuyersTableTableManager get buyers =>
      $$BuyersTableTableManager(_db, _db.buyers);
  $$CashPaymentsTableTableManager get cashPayments =>
      $$CashPaymentsTableTableManager(_db, _db.cashPayments);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderLinesTableTableManager get orderLines =>
      $$OrderLinesTableTableManager(_db, _db.orderLines);
  $$OrderLineCodesTableTableManager get orderLineCodes =>
      $$OrderLineCodesTableTableManager(_db, _db.orderLineCodes);
  $$OrderLineStorageCodesTableTableManager get orderLineStorageCodes =>
      $$OrderLineStorageCodesTableTableManager(_db, _db.orderLineStorageCodes);
  $$OrderLinePackErrorsTableTableManager get orderLinePackErrors =>
      $$OrderLinePackErrorsTableTableManager(_db, _db.orderLinePackErrors);
  $$BuyerDeliveryMarksTableTableManager get buyerDeliveryMarks =>
      $$BuyerDeliveryMarksTableTableManager(_db, _db.buyerDeliveryMarks);
  $$BuyerDeliveryPointsTableTableManager get buyerDeliveryPoints =>
      $$BuyerDeliveryPointsTableTableManager(_db, _db.buyerDeliveryPoints);
  $$BuyerDeliveryPointPhotosTableTableManager get buyerDeliveryPointPhotos =>
      $$BuyerDeliveryPointPhotosTableTableManager(
        _db,
        _db.buyerDeliveryPointPhotos,
      );
  $$PrefsTableTableManager get prefs =>
      $$PrefsTableTableManager(_db, _db.prefs);
  $$DeliveriesTableTableManager get deliveries =>
      $$DeliveriesTableTableManager(_db, _db.deliveries);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
}

class AppInfoResult {
  final DateTime? lastLoadTime;
  final int ordersTotal;
  final bool hasUnsynced;
  final bool hasUnsaved;
  final int incOrdersTotal;
  final int buyersTotal;
  AppInfoResult({
    this.lastLoadTime,
    required this.ordersTotal,
    required this.hasUnsynced,
    required this.hasUnsaved,
    required this.incOrdersTotal,
    required this.buyersTotal,
  });
}

mixin _$BuyersDaoMixin on DatabaseAccessor<AppDataStore> {
  $BuyersTable get buyers => attachedDatabase.buyers;
  $DeliveriesTable get deliveries => attachedDatabase.deliveries;
  $BuyerDeliveryMarksTable get buyerDeliveryMarks =>
      attachedDatabase.buyerDeliveryMarks;
  $BuyerDeliveryPointsTable get buyerDeliveryPoints =>
      attachedDatabase.buyerDeliveryPoints;
  $BuyerDeliveryPointPhotosTable get buyerDeliveryPointPhotos =>
      attachedDatabase.buyerDeliveryPointPhotos;
}
mixin _$OrdersDaoMixin on DatabaseAccessor<AppDataStore> {
  $IncomesTable get incomes => attachedDatabase.incomes;
  $ReceptsTable get recepts => attachedDatabase.recepts;
  $OrdersTable get orders => attachedDatabase.orders;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
  $OrderLineCodesTable get orderLineCodes => attachedDatabase.orderLineCodes;
  $OrderLineStorageCodesTable get orderLineStorageCodes =>
      attachedDatabase.orderLineStorageCodes;
  $OrderLinePackErrorsTable get orderLinePackErrors =>
      attachedDatabase.orderLinePackErrors;
}
mixin _$PaymentsDaoMixin on DatabaseAccessor<AppDataStore> {
  $DebtsTable get debts => attachedDatabase.debts;
  $CashPaymentsTable get cashPayments => attachedDatabase.cashPayments;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppDataStore> {
  $UsersTable get users => attachedDatabase.users;
}
mixin _$TasksDaoMixin on DatabaseAccessor<AppDataStore> {
  $TasksTable get tasks => attachedDatabase.tasks;
}
