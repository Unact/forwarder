import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/constants/strings.dart';
import 'app/data/database.dart';
import 'app/pages/landing/landing_page.dart';
import 'app/repositories/app_repository.dart';
import 'app/repositories/orders_repository.dart';
import 'app/repositories/payments_repository.dart';
import 'app/repositories/users_repository.dart';
import 'app/services/api.dart';
import 'app/utils/misc.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    Provider.debugCheckInvalidValueType = null;

    bool isDebug = false;
    assert(isDebug = true);

    await PackageInfo.fromPlatform();
    await FkUserAgent.init();

    Api api = await Api.init();
    AppDataStore dataStore = AppDataStore(logStatements: isDebug);
    AppRepository appRepository = AppRepository(dataStore, api);
    OrdersRepository ordersRepository = OrdersRepository(dataStore, api);
    PaymentsRepository paymentsRepository = PaymentsRepository(dataStore, api);
    UsersRepository usersRepository = UsersRepository(dataStore, api);

    await _initSentry(
      dsn: const String.fromEnvironment('FORWARDER_SENTRY_DSN'),
      capture: !isDebug,
      repository: usersRepository
    );

    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: appRepository),
          RepositoryProvider.value(value: ordersRepository),
          RepositoryProvider.value(value: paymentsRepository),
          RepositoryProvider.value(value: usersRepository)
        ],
        child: MaterialApp(
          title: Strings.ruAppName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            platform: TargetPlatform.android,
            visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          home: LandingPage(),
          locale: const Locale('ru', 'RU'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ru', 'RU'),
          ]
        )
      )
    );
  }, (Object error, StackTrace stackTrace) {
    Misc.reportError(error, stackTrace);
  });
}

Future<void> _initSentry({
    required String dsn,
    required bool capture,
    required UsersRepository repository
  }) async {
    if (!capture) return;

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.beforeSend = (SentryEvent event, {dynamic hint}) async {
          User user = await repository.getUser();

          return event.copyWith(user: SentryUser(
            id: user.id.toString(),
            username: user.username,
            email: user.email
          ));
        };
      },
    );
  }
