import 'dart:async';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/utils/nullify.dart';

abstract class DatabaseModel<T> {
  int localId;
  DateTime localTs;
  bool localInserted;
  bool localUpdated;
  bool localDeleted;
  get tableName;

  Map<String, dynamic> toMap();

  void build(Map<String, dynamic> values) {
    localId = values['local_id'];
    localTs = Nullify.parseDate(values['local_ts']);
    localInserted = Nullify.parseBool(values['local_inserted']);
    localUpdated = Nullify.parseBool(values['local_updated']);
    localDeleted = Nullify.parseBool(values['local_deleted']);
  }

  Map<String, dynamic> toExportMap() {
    Map<String, dynamic> values = toMap();
    values.addEntries({
      'local_id': localId,
      'local_ts': localTs?.toIso8601String(),
      'local_inserted': localInserted,
      'local_updated': localUpdated,
      'local_deleted': localDeleted,
    }.entries);

    return values;
  }

  Future<void> reload() async {
    build((await App.application.data.db.query(tableName, where: 'local_id = $localId')).first);
  }

  Future<DatabaseModel<T>> insert() async {
    localId = (await App.application.data.db.insert(tableName, toMap()));
    return this;
  }

  Future<DatabaseModel<T>> markInserted(bool inserted) async {
    await updateField('local_inserted', inserted);
    localInserted = inserted;
    return this;
  }

  Future<DatabaseModel<T>> markAndInsert() async {
    await insert();
    await markInserted(true);
    await reload();
    return this;
  }

  Future<DatabaseModel<T>> update() async {
    await App.application.data.db.update(tableName, toMap(), where: 'local_id = $localId');
    return this;
  }

  Future<DatabaseModel<T>> markUpdated(bool updated) async {
    await updateField('local_updated', updated);
    localUpdated = updated;
    return this;
  }

  Future<DatabaseModel<T>> markAndUpdate() async {
    await update();
    await markUpdated(true);
    await reload();
    return this;
  }

  Future<void> delete() async {
    await App.application.data.db.delete(tableName, where: 'local_id = $localId');
  }

  Future<DatabaseModel<T>> markDeleted(bool deleted) async {
    await updateField('local_deleted', deleted);
    localDeleted = deleted;
    return this;
  }

  Future<DatabaseModel<T>> updateField(String field, dynamic value) async {
    await App.application.data.db.update(tableName, {field: value}, where: 'local_id = $localId');
    return this;
  }
}
