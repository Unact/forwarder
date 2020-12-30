import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:forwarder/app/repositories/cash_payment_repository.dart';
import 'package:forwarder/app/repositories/debt_repository.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as sentryLib;

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/repositories/repositories.dart';
import 'package:forwarder/app/services/api.dart';
import 'package:forwarder/app/services/storage.dart';

class App {
  final Api api;
  final bool isDebug;
  final String version;
  final String buildNumber;
  final AppDataRepository appDataRepo;
  final BuyerRepository buyerRepo;
  final CardPaymentRepository cardPaymentRepo;
  final CashPaymentRepository cashPaymentRepo;
  final DebtRepository debtRepo;
  final OrderRepository orderRepo;
  final UserRepository userRepo;

  App._({
    @required this.api,
    @required this.isDebug,
    @required this.version,
    @required this.buildNumber,
    @required this.appDataRepo,
    @required this.buyerRepo,
    @required this.cardPaymentRepo,
    @required this.cashPaymentRepo,
    @required this.debtRepo,
    @required this.orderRepo,
    @required this.userRepo,
  }) {
    _instance = this;
  }

  static App _instance;
  static App get instance => _instance;

  static Future<App> init() async {
    if (_instance != null)
      return _instance;

    bool isDebug = false;
    assert(isDebug = true);

    WidgetsFlutterBinding.ensureInitialized();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await FlutterUserAgent.init();
    await DotEnv().load('.env');

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    Storage storage = await Storage.init();
    AppDataRepository appDataRepo = AppDataRepository(storage: storage);
    BuyerRepository buyerRepo = BuyerRepository(storage: storage);
    CardPaymentRepository cardPaymentRepo = CardPaymentRepository(storage: storage);
    CashPaymentRepository cashPaymentRepo = CashPaymentRepository(storage: storage);
    DebtRepository debtRepo = DebtRepository(storage: storage);
    OrderRepository orderRepo = OrderRepository(storage: storage);
    UserRepository userRepo = UserRepository(storage: storage);
    Api api = Api.init(repo: ApiDataRepository(storage: storage), version: version);

    await _initSentry(dsn: DotEnv().env['SENTRY_DSN'], userRepo: userRepo, capture: !isDebug);

    return App._(
      api: api,
      isDebug: isDebug,
      version: version,
      buildNumber: buildNumber,
      appDataRepo: appDataRepo,
      buyerRepo: buyerRepo,
      cardPaymentRepo: cardPaymentRepo,
      cashPaymentRepo: cashPaymentRepo,
      debtRepo: debtRepo,
      orderRepo: orderRepo,
      userRepo: userRepo,
    );
  }

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    print(error);
    print(stackTrace);
    await sentryLib.Sentry.captureException(error, stackTrace: stackTrace);
  }

  static Future<void> _initSentry({
    @required UserRepository userRepo,
    @required String dsn,
    @required bool capture
  }) async {
    if (!capture)
      return;

    await sentryLib.SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.beforeSend = (sentryLib.SentryEvent event, {dynamic hint}) {
          User user = userRepo.getUser();

          return event.copyWith(user: sentryLib.User(
            id: user.id.toString(),
            username: user.username,
            email: user.email
          ));
        };
      },
    );
  }
}
