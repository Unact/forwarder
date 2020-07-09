import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forwarder/app/models/user.dart';
import 'package:forwarder/app/modules/sentry.dart';
import 'package:forwarder/app/pages/home_page.dart';
import 'package:forwarder/app/pages/login_page.dart';
import 'package:forwarder/config/app_config.dart';
import 'package:forwarder/data/app_data.dart';

class App {
  App.setup(this.config) :
    data = AppData(config)
  {
    _setupEnv();
    _application = this;
  }

  static App _application;
  static App get application => _application;
  final String name = 'forwarder';
  final String title = 'Экспедитор';
  final AppConfig config;
  final AppData data;
  Sentry sentry;
  Widget widget;

  Future<void> run() async {
    await data.setup();
    User.init();
    config.loadSaved();
    widget = _buildWidget();

    print('Started $name in ${config.env} environment');
    runApp(widget);
  }

  void _setupEnv() {
    if (config.env != 'development') {
      sentry = Sentry.setup(config);
    }
  }

  Widget _buildWidget() {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.android
      ),
      home: User.currentUser.isLogged() ? HomePage() : LoginPage(),
      locale: Locale('ru', 'RU'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ]
    );
  }
}
