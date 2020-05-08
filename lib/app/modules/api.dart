import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:forwarder/app/app.dart';
import 'package:forwarder/app/models/user.dart';

class Api {
  static final JsonDecoder _decoder = JsonDecoder();
  static final JsonEncoder _encoder = JsonEncoder();
  static final httpClient = http.Client();
  static String workingVersion;

  static Future<dynamic> _sendRawRequest(
    String httpMethod,
    String apiMethod,
    Map<String, String> headers,
    [String body]
  ) async {
    http.Request request = http.Request(httpMethod, Uri.parse(App.application.config.apiBaseUrl + apiMethod));
    if (headers != null) request.headers.addAll(headers);
    if (body != null) request.body = body;

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Forwarder': '${App.application.config.packageInfo.version}'
    });

    try {
      return parseResponse(await http.Response.fromStream(await httpClient.send(request)));
    } catch(e) {
      if (e is SocketException || e is http.ClientException || e is HandshakeException) {
        throw ApiConnException();
      } else {
        rethrow;
      }
    }
  }

  static Future<dynamic> _sendRequest(
    String httpMethod,
    String apiMethod,
    Map<String, String> headers,
    [String body = '']
  ) async {
    if (User.currentUser.token != null) {
      headers.addAll({
        'Authorization': 'Renew client_id=${App.application.config.clientId},token=${User.currentUser.token}'
      });
    }

    try {
      return await _sendRawRequest(httpMethod, apiMethod, headers, body);
    } on AuthException {
      await relogin();
      return await _sendRequest(httpMethod, apiMethod, headers, body);
    }
  }

  static Future<dynamic> get(String method) async {
    return await _sendRequest('GET', method, {});
  }

  static Future<dynamic> post(String method, {body}) async {
    return await _sendRequest('POST', method, {}, _encoder.convert(body));
  }

  static Future<void> resetPassword(String username) async {
    await _sendRequest('POST', 'v1/reset_password', {
      'Authorization': 'Renew client_id=${App.application.config.clientId},login=$username'
    });
  }

  static Future<void> login(String username, String password) async {
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

  static Future<void> _authenticate(String username, String password) async {
    dynamic response = await _sendRawRequest('POST', 'v1/authenticate', {
      'Authorization': 'Renew client_id=${App.application.config.clientId},login=$username,password=$password'
    });
    User.currentUser.token = response['token'];
    await User.currentUser.save();
  }

  static dynamic parseResponse(http.Response response) {
      final int statusCode = response.statusCode;
      final String body = response.body;
      dynamic parsedResp;

      if (statusCode < 200) {
        throw ApiException('Ошибка при получении данных', statusCode);
      }

      if (statusCode >= 500) {
        throw ServerException(statusCode);
      }

      parsedResp = body.isEmpty ? Map<String, dynamic>() : _decoder.convert(body);

      if (statusCode == 401) {
        throw AuthException(parsedResp['error']);
      }

      if (statusCode == 410) {
        workingVersion = parsedResp['working_version'];
        throw VersionException(parsedResp['error']);
      }

      if (statusCode >= 400) {
        throw ApiException(parsedResp['error'], statusCode);
      }

      return parsedResp;
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

class VersionException extends ApiException {
  VersionException(errorMsg) : super(errorMsg, 410);
}

class ServerException extends ApiException {
  ServerException(statusCode) : super('Нет связи с сервером', statusCode);
}

class ApiConnException extends ApiException {
  ApiConnException() : super('Нет связи', 503);
}
