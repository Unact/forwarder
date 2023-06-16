import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';

class Api {
  static const String authSchema = 'Renew';
  static const _kAccessTokenKey = 'accessToken';
  static const _kRefreshTokenKey = 'refreshToken';
  static const _kUrlKey = 'url';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  late Dio _dio;
  final String _version;
  String _refreshToken;
  String _url;
  String _accessToken;

  Api._(
    this._url,
    this._accessToken,
    this._refreshToken,
    this._version
  ) {
    _dio = _createDio(_url, _version, _accessToken);
  }

  Future<void> _setApiData(String url, String accessToken, String refreshToken) async {
    await _storage.write(key: _kUrlKey, value: url);
    await _storage.write(key: _kAccessTokenKey, value: accessToken);
    await _storage.write(key: _kRefreshTokenKey, value: refreshToken);

    _url = url;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _dio = _createDio(_url, _version, _accessToken);
  }


  static Future<Api> init() async {
    return Api._(
      await _storage.read(key: _kUrlKey) ?? '',
      await _storage.read(key: _kAccessTokenKey) ?? '',
      await _storage.read(key: _kRefreshTokenKey) ?? '',
      (await PackageInfo.fromPlatform()).version
    );
  }

  bool get isLoggedIn => _accessToken != '';

  Future<void> login({
    required String url,
    required String login,
    required String password
  }) async {
    await _setApiData(url, '', '');
    Map<String, dynamic> result = await _sendRawRequest(() => _dio.post(
      'v2/authenticate',
      options: Options(headers: { 'Authorization': '$authSchema login=$login,password=$password' })
    ));

    await _setApiData(url, result['access_token'], result['refresh_token']);
  }

  Future<void> refresh() async {
    await _setApiData(_url, _refreshToken, '');
    Map<String, dynamic> result = await _sendRawRequest(() => _dio.post('v2/refresh'));

    await _setApiData(_url, result['access_token'], result['refresh_token']);
  }

  Future<void> logout() async {
    await _setApiData('', '', '');
  }

  Future<void> resetPassword({
    required String url,
    required String login
  }) async {
    await _sendRawRequest(() async {
      _dio = _createDio(_url, _version, null);

      return await _dio.post(
        'v2/reset_password',
        options: Options(headers: { 'Authorization': '$authSchema login=$login' })
      );
    });
  }

  Future<ApiUserData> getUserData() async {
    return ApiUserData.fromJson(await _sendRequest(() => _dio.get('v1/forwarder/user_info')));
  }

  Future<ApiData> getData() async {
    return ApiData.fromJson(await _sendRequest(() => _dio.get('v1/forwarder')));
  }

  Future<void> closeDay(bool closed) async {
    await _sendRequest(() => _dio.post(
      'v1/forwarder/close_day',
      data: {
        'closed': closed
      }
    ));
  }

  Future<void> deliverOrder(int orderId, List<Map<String, dynamic>> codes, bool delivered, Location location) async {
    await _sendRequest(() => _dio.post(
      'v1/forwarder/confirm_delivery',
      data: {
        'sale_order_id': orderId,
        'codes': codes,
        'delivered': delivered,
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
      }
    ));
  }

  Future<void> acceptPayment(
    List<Map<String, dynamic>> payments,
    Map<String, dynamic>? transaction,
    Location location
  ) async {
    await _sendRequest(() => _dio.post(
      'v1/forwarder/save',
      data: {
        'payments': payments,
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
      }
    ));
  }

  Future<void> cancelCardPayment(int paymentId, Map<String, dynamic> transaction) async {
    await _sendRequest(() => _dio.post(
      'v1/forwarder/cancel',
      data: {
        'id': paymentId,
        'payment_transaction': transaction,
        'local_ts': DateTime.now().toIso8601String()
      }
    ));
  }

  Future<ApiPaymentCredentials> getPaymentCredentials() async {
    return ApiPaymentCredentials.fromJson(await _sendRequest(() => _dio.get('v1/forwarder/credentials')));
  }

  Future<dynamic> _sendRequest(Future<Response> Function() request) async {
    try {
      return await _sendRawRequest(request);
    } on AuthException {
      await refresh();
      return await _sendRawRequest(request);
    }
  }

  Future<dynamic> _sendRawRequest(Future<Response> Function() rawRequest) async {
    try {
      return (await rawRequest.call()).data;
    } on DioError catch(e) {
      _onDioError(e);
    }
  }

  Dio _createDio(String url, String version, String? token) {
    String appName = Strings.appName;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      appName: version,
      'Authorization': '$authSchema token=$token',
      HttpHeaders.userAgentHeader: '$appName/$version ${FkUserAgent.userAgent}',
    };

    return Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 100000),
      receiveTimeout: const Duration(seconds: 100000),
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
      if (
        e.error is SocketException ||
        e.error is HandshakeException ||
        e.error is HttpException ||
        e.type == DioErrorType.connectionTimeout
      ) {
        throw ApiConnException();
      }

      throw e;
    }
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
