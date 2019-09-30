import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart' as sentryLib;

import 'package:forwarder/app/models/user.dart';
import 'package:forwarder/config/app_config.dart';

class Sentry {
  sentryLib.SentryClient client;

  Sentry._(this.client);

  static Sentry setup(AppConfig config) {
    sentryLib.SentryClient sentryClient = sentryLib.SentryClient(
      dsn: config.sentryDsn,
      environmentAttributes: sentryLib.Event(release: config.packageInfo.version)
    );

    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      User user = User.currentUser;
      sentryLib.Event event = sentryLib.Event(
        exception: errorDetails.exception,
        stackTrace: errorDetails.stack,
        userContext: sentryLib.User(
          id: user.id.toString(),
          username: user.username,
          email: user.email
        ),
        environment: config.env,
        extra: {
          'osVersion': config.osVersion,
          'deviceModel': config.deviceModel
        }
      );

      await sentryClient.capture(event: event);
    };

    return Sentry._(sentryClient);
  }
}
