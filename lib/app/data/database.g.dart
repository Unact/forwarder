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
  static const VerificationMeta _deliveryNdocMeta = const VerificationMeta(
    'deliveryNdoc',
  );
  @override
  late final GeneratedColumn<String> deliveryNdoc = GeneratedColumn<String>(
    'delivery_ndoc',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _missedTsMeta = const VerificationMeta(
    'missedTs',
  );
  @override
  late final GeneratedColumn<DateTime> missedTs = GeneratedColumn<DateTime>(
    'missed_ts',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _arrivalTsMeta = const VerificationMeta(
    'arrivalTs',
  );
  @override
  late final GeneratedColumn<DateTime> arrivalTs = GeneratedColumn<DateTime>(
    'arrival_ts',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departureTsMeta = const VerificationMeta(
    'departureTs',
  );
  @override
  late final GeneratedColumn<DateTime> departureTs = GeneratedColumn<DateTime>(
    'departure_ts',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    buyerId,
    deliveryId,
    deliveryNdoc,
    name,
    address,
    ord,
    needInc,
    missedTs,
    arrivalTs,
    departureTs,
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
    if (data.containsKey('delivery_ndoc')) {
      context.handle(
        _deliveryNdocMeta,
        deliveryNdoc.isAcceptableOrUnknown(
          data['delivery_ndoc']!,
          _deliveryNdocMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryNdocMeta);
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
    if (data.containsKey('missed_ts')) {
      context.handle(
        _missedTsMeta,
        missedTs.isAcceptableOrUnknown(data['missed_ts']!, _missedTsMeta),
      );
    }
    if (data.containsKey('arrival_ts')) {
      context.handle(
        _arrivalTsMeta,
        arrivalTs.isAcceptableOrUnknown(data['arrival_ts']!, _arrivalTsMeta),
      );
    }
    if (data.containsKey('departure_ts')) {
      context.handle(
        _departureTsMeta,
        departureTs.isAcceptableOrUnknown(
          data['departure_ts']!,
          _departureTsMeta,
        ),
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
      deliveryNdoc:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}delivery_ndoc'],
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
      missedTs: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}missed_ts'],
      ),
      arrivalTs: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}arrival_ts'],
      ),
      departureTs: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}departure_ts'],
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
  final String deliveryNdoc;
  final String name;
  final String address;
  final int ord;
  final bool needInc;
  final DateTime? missedTs;
  final DateTime? arrivalTs;
  final DateTime? departureTs;
  const Buyer({
    required this.buyerId,
    required this.deliveryId,
    required this.deliveryNdoc,
    required this.name,
    required this.address,
    required this.ord,
    required this.needInc,
    this.missedTs,
    this.arrivalTs,
    this.departureTs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['buyer_id'] = Variable<int>(buyerId);
    map['delivery_id'] = Variable<int>(deliveryId);
    map['delivery_ndoc'] = Variable<String>(deliveryNdoc);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['ord'] = Variable<int>(ord);
    map['need_inc'] = Variable<bool>(needInc);
    if (!nullToAbsent || missedTs != null) {
      map['missed_ts'] = Variable<DateTime>(missedTs);
    }
    if (!nullToAbsent || arrivalTs != null) {
      map['arrival_ts'] = Variable<DateTime>(arrivalTs);
    }
    if (!nullToAbsent || departureTs != null) {
      map['departure_ts'] = Variable<DateTime>(departureTs);
    }
    return map;
  }

  BuyersCompanion toCompanion(bool nullToAbsent) {
    return BuyersCompanion(
      buyerId: Value(buyerId),
      deliveryId: Value(deliveryId),
      deliveryNdoc: Value(deliveryNdoc),
      name: Value(name),
      address: Value(address),
      ord: Value(ord),
      needInc: Value(needInc),
      missedTs:
          missedTs == null && nullToAbsent
              ? const Value.absent()
              : Value(missedTs),
      arrivalTs:
          arrivalTs == null && nullToAbsent
              ? const Value.absent()
              : Value(arrivalTs),
      departureTs:
          departureTs == null && nullToAbsent
              ? const Value.absent()
              : Value(departureTs),
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
      deliveryNdoc: serializer.fromJson<String>(json['deliveryNdoc']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      ord: serializer.fromJson<int>(json['ord']),
      needInc: serializer.fromJson<bool>(json['needInc']),
      missedTs: serializer.fromJson<DateTime?>(json['missedTs']),
      arrivalTs: serializer.fromJson<DateTime?>(json['arrivalTs']),
      departureTs: serializer.fromJson<DateTime?>(json['departureTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'buyerId': serializer.toJson<int>(buyerId),
      'deliveryId': serializer.toJson<int>(deliveryId),
      'deliveryNdoc': serializer.toJson<String>(deliveryNdoc),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'ord': serializer.toJson<int>(ord),
      'needInc': serializer.toJson<bool>(needInc),
      'missedTs': serializer.toJson<DateTime?>(missedTs),
      'arrivalTs': serializer.toJson<DateTime?>(arrivalTs),
      'departureTs': serializer.toJson<DateTime?>(departureTs),
    };
  }

  Buyer copyWith({
    int? buyerId,
    int? deliveryId,
    String? deliveryNdoc,
    String? name,
    String? address,
    int? ord,
    bool? needInc,
    Value<DateTime?> missedTs = const Value.absent(),
    Value<DateTime?> arrivalTs = const Value.absent(),
    Value<DateTime?> departureTs = const Value.absent(),
  }) => Buyer(
    buyerId: buyerId ?? this.buyerId,
    deliveryId: deliveryId ?? this.deliveryId,
    deliveryNdoc: deliveryNdoc ?? this.deliveryNdoc,
    name: name ?? this.name,
    address: address ?? this.address,
    ord: ord ?? this.ord,
    needInc: needInc ?? this.needInc,
    missedTs: missedTs.present ? missedTs.value : this.missedTs,
    arrivalTs: arrivalTs.present ? arrivalTs.value : this.arrivalTs,
    departureTs: departureTs.present ? departureTs.value : this.departureTs,
  );
  Buyer copyWithCompanion(BuyersCompanion data) {
    return Buyer(
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      deliveryId:
          data.deliveryId.present ? data.deliveryId.value : this.deliveryId,
      deliveryNdoc:
          data.deliveryNdoc.present
              ? data.deliveryNdoc.value
              : this.deliveryNdoc,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      ord: data.ord.present ? data.ord.value : this.ord,
      needInc: data.needInc.present ? data.needInc.value : this.needInc,
      missedTs: data.missedTs.present ? data.missedTs.value : this.missedTs,
      arrivalTs: data.arrivalTs.present ? data.arrivalTs.value : this.arrivalTs,
      departureTs:
          data.departureTs.present ? data.departureTs.value : this.departureTs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Buyer(')
          ..write('buyerId: $buyerId, ')
          ..write('deliveryId: $deliveryId, ')
          ..write('deliveryNdoc: $deliveryNdoc, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('ord: $ord, ')
          ..write('needInc: $needInc, ')
          ..write('missedTs: $missedTs, ')
          ..write('arrivalTs: $arrivalTs, ')
          ..write('departureTs: $departureTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    buyerId,
    deliveryId,
    deliveryNdoc,
    name,
    address,
    ord,
    needInc,
    missedTs,
    arrivalTs,
    departureTs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Buyer &&
          other.buyerId == this.buyerId &&
          other.deliveryId == this.deliveryId &&
          other.deliveryNdoc == this.deliveryNdoc &&
          other.name == this.name &&
          other.address == this.address &&
          other.ord == this.ord &&
          other.needInc == this.needInc &&
          other.missedTs == this.missedTs &&
          other.arrivalTs == this.arrivalTs &&
          other.departureTs == this.departureTs);
}

class BuyersCompanion extends UpdateCompanion<Buyer> {
  final Value<int> buyerId;
  final Value<int> deliveryId;
  final Value<String> deliveryNdoc;
  final Value<String> name;
  final Value<String> address;
  final Value<int> ord;
  final Value<bool> needInc;
  final Value<DateTime?> missedTs;
  final Value<DateTime?> arrivalTs;
  final Value<DateTime?> departureTs;
  final Value<int> rowid;
  const BuyersCompanion({
    this.buyerId = const Value.absent(),
    this.deliveryId = const Value.absent(),
    this.deliveryNdoc = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.ord = const Value.absent(),
    this.needInc = const Value.absent(),
    this.missedTs = const Value.absent(),
    this.arrivalTs = const Value.absent(),
    this.departureTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BuyersCompanion.insert({
    required int buyerId,
    required int deliveryId,
    required String deliveryNdoc,
    required String name,
    required String address,
    required int ord,
    required bool needInc,
    this.missedTs = const Value.absent(),
    this.arrivalTs = const Value.absent(),
    this.departureTs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : buyerId = Value(buyerId),
       deliveryId = Value(deliveryId),
       deliveryNdoc = Value(deliveryNdoc),
       name = Value(name),
       address = Value(address),
       ord = Value(ord),
       needInc = Value(needInc);
  static Insertable<Buyer> custom({
    Expression<int>? buyerId,
    Expression<int>? deliveryId,
    Expression<String>? deliveryNdoc,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? ord,
    Expression<bool>? needInc,
    Expression<DateTime>? missedTs,
    Expression<DateTime>? arrivalTs,
    Expression<DateTime>? departureTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (buyerId != null) 'buyer_id': buyerId,
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (deliveryNdoc != null) 'delivery_ndoc': deliveryNdoc,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (ord != null) 'ord': ord,
      if (needInc != null) 'need_inc': needInc,
      if (missedTs != null) 'missed_ts': missedTs,
      if (arrivalTs != null) 'arrival_ts': arrivalTs,
      if (departureTs != null) 'departure_ts': departureTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BuyersCompanion copyWith({
    Value<int>? buyerId,
    Value<int>? deliveryId,
    Value<String>? deliveryNdoc,
    Value<String>? name,
    Value<String>? address,
    Value<int>? ord,
    Value<bool>? needInc,
    Value<DateTime?>? missedTs,
    Value<DateTime?>? arrivalTs,
    Value<DateTime?>? departureTs,
    Value<int>? rowid,
  }) {
    return BuyersCompanion(
      buyerId: buyerId ?? this.buyerId,
      deliveryId: deliveryId ?? this.deliveryId,
      deliveryNdoc: deliveryNdoc ?? this.deliveryNdoc,
      name: name ?? this.name,
      address: address ?? this.address,
      ord: ord ?? this.ord,
      needInc: needInc ?? this.needInc,
      missedTs: missedTs ?? this.missedTs,
      arrivalTs: arrivalTs ?? this.arrivalTs,
      departureTs: departureTs ?? this.departureTs,
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
    if (deliveryNdoc.present) {
      map['delivery_ndoc'] = Variable<String>(deliveryNdoc.value);
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
    if (missedTs.present) {
      map['missed_ts'] = Variable<DateTime>(missedTs.value);
    }
    if (arrivalTs.present) {
      map['arrival_ts'] = Variable<DateTime>(arrivalTs.value);
    }
    if (departureTs.present) {
      map['departure_ts'] = Variable<DateTime>(departureTs.value);
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
          ..write('deliveryNdoc: $deliveryNdoc, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('ord: $ord, ')
          ..write('needInc: $needInc, ')
          ..write('missedTs: $missedTs, ')
          ..write('arrivalTs: $arrivalTs, ')
          ..write('departureTs: $departureTs, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canceledMeta = const VerificationMeta(
    'canceled',
  );
  @override
  late final GeneratedColumn<bool> canceled = GeneratedColumn<bool>(
    'canceled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("canceled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isLinkMeta = const VerificationMeta('isLink');
  @override
  late final GeneratedColumn<bool> isLink = GeneratedColumn<bool>(
    'is_link',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_link" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buyerId,
    orderId,
    summ,
    ddate,
    transactionId,
    canceled,
    isLink,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardPayment> instance, {
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
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('canceled')) {
      context.handle(
        _canceledMeta,
        canceled.isAcceptableOrUnknown(data['canceled']!, _canceledMeta),
      );
    } else if (isInserting) {
      context.missing(_canceledMeta);
    }
    if (data.containsKey('is_link')) {
      context.handle(
        _isLinkMeta,
        isLink.isAcceptableOrUnknown(data['is_link']!, _isLinkMeta),
      );
    } else if (isInserting) {
      context.missing(_isLinkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardPayment(
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
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      canceled:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}canceled'],
          )!,
      isLink:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_link'],
          )!,
    );
  }

  @override
  $CardPaymentsTable createAlias(String alias) {
    return $CardPaymentsTable(attachedDatabase, alias);
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
  const CardPayment({
    required this.id,
    required this.buyerId,
    required this.orderId,
    required this.summ,
    required this.ddate,
    this.transactionId,
    required this.canceled,
    required this.isLink,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buyer_id'] = Variable<int>(buyerId);
    map['order_id'] = Variable<int>(orderId);
    map['summ'] = Variable<double>(summ);
    map['ddate'] = Variable<DateTime>(ddate);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
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
      transactionId:
          transactionId == null && nullToAbsent
              ? const Value.absent()
              : Value(transactionId),
      canceled: Value(canceled),
      isLink: Value(isLink),
    );
  }

  factory CardPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  CardPayment copyWith({
    int? id,
    int? buyerId,
    int? orderId,
    double? summ,
    DateTime? ddate,
    Value<String?> transactionId = const Value.absent(),
    bool? canceled,
    bool? isLink,
  }) => CardPayment(
    id: id ?? this.id,
    buyerId: buyerId ?? this.buyerId,
    orderId: orderId ?? this.orderId,
    summ: summ ?? this.summ,
    ddate: ddate ?? this.ddate,
    transactionId:
        transactionId.present ? transactionId.value : this.transactionId,
    canceled: canceled ?? this.canceled,
    isLink: isLink ?? this.isLink,
  );
  CardPayment copyWithCompanion(CardPaymentsCompanion data) {
    return CardPayment(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      summ: data.summ.present ? data.summ.value : this.summ,
      ddate: data.ddate.present ? data.ddate.value : this.ddate,
      transactionId:
          data.transactionId.present
              ? data.transactionId.value
              : this.transactionId,
      canceled: data.canceled.present ? data.canceled.value : this.canceled,
      isLink: data.isLink.present ? data.isLink.value : this.isLink,
    );
  }

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
    id,
    buyerId,
    orderId,
    summ,
    ddate,
    transactionId,
    canceled,
    isLink,
  );
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
  }) : buyerId = Value(buyerId),
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
    Expression<String>? transactionId,
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

  CardPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? buyerId,
    Value<int>? orderId,
    Value<double>? summ,
    Value<DateTime>? ddate,
    Value<String?>? transactionId,
    Value<bool>? canceled,
    Value<bool>? isLink,
  }) {
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
      map['transaction_id'] = Variable<String>(transactionId.value);
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
          ..write('needScan: $needScan')
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
          other.needScan == this.needScan);
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
       needScan = Value(needScan);
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
          ..write('needScan: $needScan')
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
    orderId,
    subid,
    code,
    amount,
    isDataMatrix,
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
  final int orderId;
  final int subid;
  final String code;
  final int amount;
  final bool isDataMatrix;
  final DateTime localTs;
  const OrderLineCode({
    required this.orderId,
    required this.subid,
    required this.code,
    required this.amount,
    required this.isDataMatrix,
    required this.localTs,
  });
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

  factory OrderLineCode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  OrderLineCode copyWith({
    int? orderId,
    int? subid,
    String? code,
    int? amount,
    bool? isDataMatrix,
    DateTime? localTs,
  }) => OrderLineCode(
    orderId: orderId ?? this.orderId,
    subid: subid ?? this.subid,
    code: code ?? this.code,
    amount: amount ?? this.amount,
    isDataMatrix: isDataMatrix ?? this.isDataMatrix,
    localTs: localTs ?? this.localTs,
  );
  OrderLineCode copyWithCompanion(OrderLineCodesCompanion data) {
    return OrderLineCode(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      subid: data.subid.present ? data.subid.value : this.subid,
      code: data.code.present ? data.code.value : this.code,
      amount: data.amount.present ? data.amount.value : this.amount,
      isDataMatrix:
          data.isDataMatrix.present
              ? data.isDataMatrix.value
              : this.isDataMatrix,
      localTs: data.localTs.present ? data.localTs.value : this.localTs,
    );
  }

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
  final Value<int> rowid;
  const OrderLineCodesCompanion({
    this.orderId = const Value.absent(),
    this.subid = const Value.absent(),
    this.code = const Value.absent(),
    this.amount = const Value.absent(),
    this.isDataMatrix = const Value.absent(),
    this.localTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLineCodesCompanion.insert({
    required int orderId,
    required int subid,
    required String code,
    required int amount,
    required bool isDataMatrix,
    required DateTime localTs,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
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
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (subid != null) 'subid': subid,
      if (code != null) 'code': code,
      if (amount != null) 'amount': amount,
      if (isDataMatrix != null) 'is_data_matrix': isDataMatrix,
      if (localTs != null) 'local_ts': localTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLineCodesCompanion copyWith({
    Value<int>? orderId,
    Value<int>? subid,
    Value<String>? code,
    Value<int>? amount,
    Value<bool>? isDataMatrix,
    Value<DateTime>? localTs,
    Value<int>? rowid,
  }) {
    return OrderLineCodesCompanion(
      orderId: orderId ?? this.orderId,
      subid: subid ?? this.subid,
      code: code ?? this.code,
      amount: amount ?? this.amount,
      isDataMatrix: isDataMatrix ?? this.isDataMatrix,
      localTs: localTs ?? this.localTs,
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
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (isDataMatrix.present) {
      map['is_data_matrix'] = Variable<bool>(isDataMatrix.value);
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
          ..write('orderId: $orderId, ')
          ..write('subid: $subid, ')
          ..write('code: $code, ')
          ..write('amount: $amount, ')
          ..write('isDataMatrix: $isDataMatrix, ')
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

abstract class _$AppDataStore extends GeneratedDatabase {
  _$AppDataStore(QueryExecutor e) : super(e);
  $AppDataStoreManager get managers => $AppDataStoreManager(this);
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
  late final $OrderLineStorageCodesTable orderLineStorageCodes =
      $OrderLineStorageCodesTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final OrdersDao ordersDao = OrdersDao(this as AppDataStore);
  late final PaymentsDao paymentsDao = PaymentsDao(this as AppDataStore);
  late final UsersDao usersDao = UsersDao(this as AppDataStore);
  Selectable<AppInfoResult> appInfo() {
    return customSelect(
      'SELECT prefs.*, (SELECT COUNT(*) FROM orders) AS orders_total, (SELECT COUNT(*) FROM orders WHERE is_inc = 1) + (SELECT COUNT(*) FROM orders WHERE NOT EXISTS (SELECT 1 FROM buyers WHERE buyers.buyer_id = orders.buyer_id) = 1) AS inc_orders_total, (SELECT COUNT(*) FROM buyers) AS buyers_total FROM prefs',
      variables: [],
      readsFrom: {orders, buyers, prefs},
    ).map(
      (QueryRow row) => AppInfoResult(
        lastLoadTime: row.readNullable<DateTime>('last_load_time'),
        ordersTotal: row.read<int>('orders_total'),
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
    cardPayments,
    cashPayments,
    debts,
    orders,
    orderLines,
    orderLineCodes,
    orderLineStorageCodes,
    prefs,
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
      required String deliveryNdoc,
      required String name,
      required String address,
      required int ord,
      required bool needInc,
      Value<DateTime?> missedTs,
      Value<DateTime?> arrivalTs,
      Value<DateTime?> departureTs,
      Value<int> rowid,
    });
typedef $$BuyersTableUpdateCompanionBuilder =
    BuyersCompanion Function({
      Value<int> buyerId,
      Value<int> deliveryId,
      Value<String> deliveryNdoc,
      Value<String> name,
      Value<String> address,
      Value<int> ord,
      Value<bool> needInc,
      Value<DateTime?> missedTs,
      Value<DateTime?> arrivalTs,
      Value<DateTime?> departureTs,
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

  ColumnFilters<String> get deliveryNdoc => $composableBuilder(
    column: $table.deliveryNdoc,
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

  ColumnFilters<DateTime> get missedTs => $composableBuilder(
    column: $table.missedTs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get arrivalTs => $composableBuilder(
    column: $table.arrivalTs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get departureTs => $composableBuilder(
    column: $table.departureTs,
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

  ColumnOrderings<String> get deliveryNdoc => $composableBuilder(
    column: $table.deliveryNdoc,
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

  ColumnOrderings<DateTime> get missedTs => $composableBuilder(
    column: $table.missedTs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get arrivalTs => $composableBuilder(
    column: $table.arrivalTs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get departureTs => $composableBuilder(
    column: $table.departureTs,
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

  GeneratedColumn<String> get deliveryNdoc => $composableBuilder(
    column: $table.deliveryNdoc,
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

  GeneratedColumn<DateTime> get missedTs =>
      $composableBuilder(column: $table.missedTs, builder: (column) => column);

  GeneratedColumn<DateTime> get arrivalTs =>
      $composableBuilder(column: $table.arrivalTs, builder: (column) => column);

  GeneratedColumn<DateTime> get departureTs => $composableBuilder(
    column: $table.departureTs,
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
                Value<String> deliveryNdoc = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> ord = const Value.absent(),
                Value<bool> needInc = const Value.absent(),
                Value<DateTime?> missedTs = const Value.absent(),
                Value<DateTime?> arrivalTs = const Value.absent(),
                Value<DateTime?> departureTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuyersCompanion(
                buyerId: buyerId,
                deliveryId: deliveryId,
                deliveryNdoc: deliveryNdoc,
                name: name,
                address: address,
                ord: ord,
                needInc: needInc,
                missedTs: missedTs,
                arrivalTs: arrivalTs,
                departureTs: departureTs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int buyerId,
                required int deliveryId,
                required String deliveryNdoc,
                required String name,
                required String address,
                required int ord,
                required bool needInc,
                Value<DateTime?> missedTs = const Value.absent(),
                Value<DateTime?> arrivalTs = const Value.absent(),
                Value<DateTime?> departureTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuyersCompanion.insert(
                buyerId: buyerId,
                deliveryId: deliveryId,
                deliveryNdoc: deliveryNdoc,
                name: name,
                address: address,
                ord: ord,
                needInc: needInc,
                missedTs: missedTs,
                arrivalTs: arrivalTs,
                departureTs: departureTs,
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
typedef $$CardPaymentsTableCreateCompanionBuilder =
    CardPaymentsCompanion Function({
      Value<int> id,
      required int buyerId,
      required int orderId,
      required double summ,
      required DateTime ddate,
      Value<String?> transactionId,
      required bool canceled,
      required bool isLink,
    });
typedef $$CardPaymentsTableUpdateCompanionBuilder =
    CardPaymentsCompanion Function({
      Value<int> id,
      Value<int> buyerId,
      Value<int> orderId,
      Value<double> summ,
      Value<DateTime> ddate,
      Value<String?> transactionId,
      Value<bool> canceled,
      Value<bool> isLink,
    });

class $$CardPaymentsTableFilterComposer
    extends Composer<_$AppDataStore, $CardPaymentsTable> {
  $$CardPaymentsTableFilterComposer({
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

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canceled => $composableBuilder(
    column: $table.canceled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLink => $composableBuilder(
    column: $table.isLink,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CardPaymentsTableOrderingComposer
    extends Composer<_$AppDataStore, $CardPaymentsTable> {
  $$CardPaymentsTableOrderingComposer({
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

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canceled => $composableBuilder(
    column: $table.canceled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLink => $composableBuilder(
    column: $table.isLink,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CardPaymentsTableAnnotationComposer
    extends Composer<_$AppDataStore, $CardPaymentsTable> {
  $$CardPaymentsTableAnnotationComposer({
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

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canceled =>
      $composableBuilder(column: $table.canceled, builder: (column) => column);

  GeneratedColumn<bool> get isLink =>
      $composableBuilder(column: $table.isLink, builder: (column) => column);
}

class $$CardPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDataStore,
          $CardPaymentsTable,
          CardPayment,
          $$CardPaymentsTableFilterComposer,
          $$CardPaymentsTableOrderingComposer,
          $$CardPaymentsTableAnnotationComposer,
          $$CardPaymentsTableCreateCompanionBuilder,
          $$CardPaymentsTableUpdateCompanionBuilder,
          (
            CardPayment,
            BaseReferences<_$AppDataStore, $CardPaymentsTable, CardPayment>,
          ),
          CardPayment,
          PrefetchHooks Function()
        > {
  $$CardPaymentsTableTableManager(_$AppDataStore db, $CardPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CardPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CardPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CardPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buyerId = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<double> summ = const Value.absent(),
                Value<DateTime> ddate = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<bool> canceled = const Value.absent(),
                Value<bool> isLink = const Value.absent(),
              }) => CardPaymentsCompanion(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                summ: summ,
                ddate: ddate,
                transactionId: transactionId,
                canceled: canceled,
                isLink: isLink,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buyerId,
                required int orderId,
                required double summ,
                required DateTime ddate,
                Value<String?> transactionId = const Value.absent(),
                required bool canceled,
                required bool isLink,
              }) => CardPaymentsCompanion.insert(
                id: id,
                buyerId: buyerId,
                orderId: orderId,
                summ: summ,
                ddate: ddate,
                transactionId: transactionId,
                canceled: canceled,
                isLink: isLink,
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

typedef $$CardPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataStore,
      $CardPaymentsTable,
      CardPayment,
      $$CardPaymentsTableFilterComposer,
      $$CardPaymentsTableOrderingComposer,
      $$CardPaymentsTableAnnotationComposer,
      $$CardPaymentsTableCreateCompanionBuilder,
      $$CardPaymentsTableUpdateCompanionBuilder,
      (
        CardPayment,
        BaseReferences<_$AppDataStore, $CardPaymentsTable, CardPayment>,
      ),
      CardPayment,
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
      required int orderId,
      required int subid,
      required String code,
      required int amount,
      required bool isDataMatrix,
      required DateTime localTs,
      Value<int> rowid,
    });
typedef $$OrderLineCodesTableUpdateCompanionBuilder =
    OrderLineCodesCompanion Function({
      Value<int> orderId,
      Value<int> subid,
      Value<String> code,
      Value<int> amount,
      Value<bool> isDataMatrix,
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
                Value<int> orderId = const Value.absent(),
                Value<int> subid = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<bool> isDataMatrix = const Value.absent(),
                Value<DateTime> localTs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderLineCodesCompanion(
                orderId: orderId,
                subid: subid,
                code: code,
                amount: amount,
                isDataMatrix: isDataMatrix,
                localTs: localTs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int orderId,
                required int subid,
                required String code,
                required int amount,
                required bool isDataMatrix,
                required DateTime localTs,
                Value<int> rowid = const Value.absent(),
              }) => OrderLineCodesCompanion.insert(
                orderId: orderId,
                subid: subid,
                code: code,
                amount: amount,
                isDataMatrix: isDataMatrix,
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
  $$CardPaymentsTableTableManager get cardPayments =>
      $$CardPaymentsTableTableManager(_db, _db.cardPayments);
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
  $$PrefsTableTableManager get prefs =>
      $$PrefsTableTableManager(_db, _db.prefs);
}

class AppInfoResult {
  final DateTime? lastLoadTime;
  final int ordersTotal;
  final int incOrdersTotal;
  final int buyersTotal;
  AppInfoResult({
    this.lastLoadTime,
    required this.ordersTotal,
    required this.incOrdersTotal,
    required this.buyersTotal,
  });
}

mixin _$OrdersDaoMixin on DatabaseAccessor<AppDataStore> {
  $BuyersTable get buyers => attachedDatabase.buyers;
  $IncomesTable get incomes => attachedDatabase.incomes;
  $ReceptsTable get recepts => attachedDatabase.recepts;
  $OrdersTable get orders => attachedDatabase.orders;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
  $OrderLineCodesTable get orderLineCodes => attachedDatabase.orderLineCodes;
  $OrderLineStorageCodesTable get orderLineStorageCodes =>
      attachedDatabase.orderLineStorageCodes;
}
mixin _$PaymentsDaoMixin on DatabaseAccessor<AppDataStore> {
  $DebtsTable get debts => attachedDatabase.debts;
  $CashPaymentsTable get cashPayments => attachedDatabase.cashPayments;
  $CardPaymentsTable get cardPayments => attachedDatabase.cardPayments;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppDataStore> {
  $UsersTable get users => attachedDatabase.users;
}
