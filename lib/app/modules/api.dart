import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/user.dart';

class Api {
  static Future<void> resetPassword(String username) async {
    await _request(
      'POST',
      'v1/reset_password',
      headers: {
        'Authorization': 'Renew login=$username'
      }
    );
  }

  static Future<void> login(String username, String password) async {
    await User.currentUser.reset();
    await _authenticate(username, password);

    User.currentUser.username = username;
    User.currentUser.password = password;
    await User.currentUser.save();
    await User.currentUser.loadDataFromRemote();
  }

  static Future<void> logout() async {
    await User.currentUser.reset();
  }

  static Future<void> relogin() async {
    User.currentUser.token = null;
    await _authenticate(User.currentUser.username, User.currentUser.password);
  }

  static Future<dynamic> get(
    String method,
    {
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
    }
  ) async {
    return await request('GET', method, headers: headers, queryParameters: queryParameters);
  }

  static Future<dynamic> post(
    String method,
    {
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      dynamic data,
      File file,
      String fileKey = 'file'
    }
  ) async {
    return await request(
      'POST',
      method,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
      file: file,
      fileKey: fileKey
    );
  }

  static Future<dynamic> request(
    String method,
    String apiMethod,
    {
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      dynamic data,
      File file,
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
      return await _request(method, apiMethod, headers: headers, data: dataToSend, queryParameters: queryParameters);
    } on AuthException {
      await relogin();

      if (dataToSend is FormData) {
        dataToSend = _createFileFormData(data, file, fileKey);
      }

      return await _request(method, apiMethod, headers: headers, data: dataToSend, queryParameters: queryParameters);
    }
  }

  static Dio _createDio([Map<String, String> headers = const {}]) {
    String version = App.application.config.packageInfo.version;

    if (headers == null) headers = {};

    if (User.currentUser.token != null) {
      headers.addAll({
        'Authorization': 'Renew token=${User.currentUser.token}'
      });
    }
  FlutterUserAgent.getProperty('userAgent');
    headers.addAll({
      'Accept': 'application/json',
      'Forwarder': '$version',
      HttpHeaders.userAgentHeader: 'Forwarder/$version ${FlutterUserAgent.userAgent}',
    });

    return Dio(BaseOptions(
      baseUrl: App.application.config.apiBaseUrl,
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: headers,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
  }

  static void _onDioError(DioError e) {
    if (e.response != null) {
      final int statusCode = e.response.statusCode;
      final dynamic body = e.response.data;

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
      if (e.error is SocketException) {
        throw ApiConnException();
      }

      throw e;
    }
  }

  static FormData _createFileFormData(Map<String, dynamic> data, File file, String fileKey) {
    Map<String, dynamic> dataToAdd = data;
    dataToAdd[fileKey] = MultipartFile.fromBytes(file.readAsBytesSync(), filename: file.path.split('/').last);

    return FormData.fromMap(dataToAdd);
  }

  static Future<dynamic> _request(
    String method,
    String apiMethod,
    {
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      data
    }
  ) async {
    Dio dio = _createDio(headers);
    dio.options.method = method;

    try {
      return (await dio.request(apiMethod, data: data, queryParameters: queryParameters)).data;
    } on DioError catch(e) {
      _onDioError(e);
    }
  }

  static Future<void> _authenticate(String username, String password) async {
    dynamic response = await _request(
      'POST',
      'v1/authenticate',
      headers: {
        'Authorization': 'Renew login=$username,password=$password'
      }
    );
    User.currentUser.token = response['token'];
    await User.currentUser.save();
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
