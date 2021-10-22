import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/repositories/repositories.dart';
import 'package:forwarder/app/services/api.dart';
import 'package:forwarder/app/services/storage.dart';

class App {
  final bool isDebug;
  final String version;
  final String buildNumber;

  App._({
    required this.isDebug,
    required this.version,
    required this.buildNumber,
  }) {
    _instance = this;
  }

  static App? _instance;
  static App? get instance => _instance;

  static Future<App> init() async {
    if (_instance != null)
      return _instance!;

    bool isDebug = false;
    assert(isDebug = true);

    WidgetsFlutterBinding.ensureInitialized();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await FkUserAgent.init();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    await Storage.init();
    await Api.init();
    await _initSentry(dsn: const String.fromEnvironment('FORWARDER_SENTRY_DSN'), capture: !isDebug);

    return App._(
      isDebug: isDebug,
      version: version,
      buildNumber: buildNumber,
    );
  }

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    print(error);
    print(stackTrace);
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  static Future<void> _initSentry({
    required String dsn,
    required bool capture
  }) async {
    if (!capture)
      return;

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.beforeSend = (SentryEvent event, {dynamic hint}) {
          User user = UserRepository(storage: Storage.instance!).getUser();

          return event.copyWith(user: SentryUser(
            id: user.id.toString(),
            username: user.username,
            email: user.email
          ));
        };
      },
    );
  }
}
