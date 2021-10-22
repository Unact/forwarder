import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info/package_info.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/repositories/repositories.dart';
import 'package:forwarder/app/services/storage.dart';

class Api {
  final ApiDataRepository repo;
  final String version;
  static const String authSchema = 'Renew';

  Api._({required this.repo, required this.version}) {
    _instance = this;
  }

  static Api? _instance;
  static Api? get instance => _instance;

  static Future<Api> init() async {
    if (_instance != null)
      return _instance!;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return Api._(repo: ApiDataRepository(storage: Storage.instance!), version: packageInfo.version);
  }

  Future<void> resetPassword(String url, String login) async {
    await logout();
    await _rawRequest(
      ApiData(login: login, url: url),
      'POST',
      'v1/reset_password',
      headers: {
        'Authorization': '$authSchema login=$login'
      }
    );
  }

  Future<ApiData> login(String url, String login, String password) async {
    ApiData loginData = ApiData(login: login, password: password, url: url);

    ApiData authData = await _authenticate(loginData);
    await repo.setApiData(authData);

    return authData;
  }

  Future<void> logout() async {
    await repo.resetApiData();
  }

  Future<ApiData> relogin() async {
    ApiData currentAuthData = repo.getApiData();
    return await login(currentAuthData.url!, currentAuthData.login!, currentAuthData.password!);
  }

  Future<GetUserDataResponse> getUserData() async {
    return GetUserDataResponse.fromJson(await _get('v1/forwarder/user_info'));
  }

  Future<GetDataResponse> getData() async {
    return GetDataResponse.fromJson(await _get('v1/forwarder'));
  }

  Future<void> closeDay(bool closed) async {
    await _post('v1/forwarder/close_day', data: { 'closed': closed });
  }

  Future<void> deliverOrder(Order order, Location location) async {
    await _post('v1/forwarder/confirm_delivery', data: {
      'sale_order_id': order.id,
      'delivered': order.delivered,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'accuracy': location.accuracy,
        'altitude': location.altitude,
        'speed': location.speed,
        'heading': location.heading,
        'point_ts': location.pointTs?.toIso8601String()
      },
      'local_ts': DateTime.now().toIso8601String()
    });
  }

  Future<void> acceptPayment(List<Debt> debts, Map<String, dynamic>? transaction, Location location) async {
    await _post('v1/forwarder/save', data: {
      'payments': debts.map((e) => {
        'id': e.id,
        'payment_sum': e.paymentSum
      }).toList(),
      'payment_transaction': transaction,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'accuracy': location.accuracy,
        'altitude': location.altitude,
        'speed': location.speed,
        'heading': location.heading,
        'point_ts': location.pointTs?.toIso8601String()
      },
      'local_ts': DateTime.now().toIso8601String()
    });
  }

  Future<void> cancelCardPayment(CardPayment payment, Map<String, dynamic> transaction) async {
    await _post('v1/forwarder/cancel', data: {
      'id': payment.id,
      'payment_transaction': transaction,
      'local_ts': DateTime.now().toIso8601String()
    });
  }

  Future<GetPaymentCredentialsResponse> getPaymentCredentials() async {
    return GetPaymentCredentialsResponse.fromJson(await _get('v1/forwarder/credentials'));
  }

  Future<dynamic> _get(
    String method,
    {
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
    }
  ) async {
    return await _request(
      repo.getApiData(),
      'GET',
      method,
      headers: headers,
      queryParameters: queryParameters
    );
  }

  Future<dynamic> _post(
    String method,
    {
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      File? file,
      String fileKey = 'file'
    }
  ) async {
    return await _request(
      repo.getApiData(),
      'POST',
      method,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
      file: file,
      fileKey: fileKey
    );
  }

  Future<dynamic> _request(
    ApiData apiData,
    String method,
    String apiMethod,
    {
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      File? file,
      String fileKey = 'file'
    }
  ) async {
    dynamic dataToSend = data;

    if (data is! Map<String, dynamic> && file != null) {
      throw 'file not empty, data must be Map<String, dynamic>';
    }

    if (file != null) {
      dataToSend = _createFileFormData(data, file, fileKey);
    }

    try {
      return await _rawRequest(
        apiData,
        method,
        apiMethod,
        headers: headers,
        data: dataToSend,
        queryParameters: queryParameters
      );
    } on AuthException {
      if (dataToSend is FormData) {
        dataToSend = _createFileFormData(data, file!, fileKey);
      }

      return await _rawRequest(
        await relogin(),
        method,
        apiMethod,
        headers: headers,
        data: dataToSend,
        queryParameters: queryParameters
      );
    }
  }

  Dio _createDio(ApiData apiData, String method, [Map<String, String>? headers = const {}]) {
    String appName = Strings.appName;

    if (headers == null) headers = {};

    if (apiData.token != null) {
      headers.addAll({
        'Authorization': '$authSchema token=${apiData.token}'
      });
    }

    headers.addAll({
      'Accept': 'application/json',
      appName: '$version',
      HttpHeaders.userAgentHeader: '$appName/$version ${FkUserAgent.userAgent}',
    });

    return Dio(BaseOptions(
      method: method,
      baseUrl: apiData.url!,
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: headers,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
  }

  static void _onDioError(DioError e) {
    if (e.response != null) {
      final int statusCode = e.response!.statusCode!;
      final dynamic body = e.response!.data;

      if (statusCode < 200) {
        throw ApiException('Ошибка при получении данных', statusCode);
      }

      if (statusCode >= 500) {
        throw ServerException(statusCode);
      }

      if (statusCode == 401) {
        throw AuthException(body['error']);
      }

      if (statusCode == 410) {
        throw VersionException(body['error']);
      }

      if (statusCode >= 400) {
        throw ApiException(body['error'], statusCode);
      }
    } else {
      throw ApiConnException();
    }
  }

  FormData _createFileFormData(Map<String, dynamic> data, File file, String fileKey) {
    Map<String, dynamic> dataToAdd = data;
    dataToAdd[fileKey] = MultipartFile.fromBytes(file.readAsBytesSync(), filename: file.path.split('/').last);

    return FormData.fromMap(dataToAdd);
  }

  Future<dynamic> _rawRequest(
    ApiData apiData,
    String method,
    String apiMethod,
    {
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      data
    }
  ) async {
    Dio dio = _createDio(apiData, method, headers);

    try {
      return (await dio.request(apiMethod, data: data, queryParameters: queryParameters)).data;
    } on DioError catch(e) {
      _onDioError(e);
    }
  }

  Future<ApiData> _authenticate(ApiData apiData) async {
    dynamic response = await _rawRequest(
      apiData,
      'POST',
      'v1/authenticate',
      headers: {
        'Authorization': '$authSchema login=${apiData.login},password=${apiData.password}'
      }
    );

    return ApiData(
      login: apiData.login,
      password: apiData.password,
      url: apiData.url,
      token: response['token']
    );
  }
}

class ApiException implements Exception {
  String errorMsg;
  int statusCode;

  ApiException(this.errorMsg, this.statusCode);
}

class AuthException extends ApiException {
  AuthException(errorMsg) : super(errorMsg, 401);
}

class ServerException extends ApiException {
  ServerException(statusCode) : super('Нет связи с сервером', statusCode);
}

class ApiConnException extends ApiException {
  ApiConnException() : super('Нет связи', 503);
}

class VersionException extends ApiException {
  VersionException(errorMsg) : super(errorMsg, 410);
}
