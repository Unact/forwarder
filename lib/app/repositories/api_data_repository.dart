import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/services/storage.dart';

class ApiDataRepository {
  final Storage storage;

  ApiDataRepository({@required this.storage});

  ApiData getApiData() {
    String data = storage.prefs.getString('apiData');
    return data == null ? ApiData() : ApiData.fromJson(json.decode(data));
  }

  Future<void> setApiData(ApiData apiData) async {
    await storage.prefs.setString('apiData', json.encode(apiData.toJson()));
  }

  Future<void> resetApiData() async {
    await setApiData(ApiData());
  }
}
