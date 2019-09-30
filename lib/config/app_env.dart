import 'dart:async' show Future;

import 'package:dotenv/dotenv.dart' as dotenv show Parser;
import 'package:flutter/services.dart' show rootBundle;

const AppEnv appEnv = AppEnv._();

// Позаимстововал часть имплементации dotenv,
// к сожалению его целиком использовать не получается, так как он не читает ассеты флаттера
class AppEnv {
  static final Map _env = Map();

  const AppEnv._();

  String operator [](String name) => _env[name];

  Map toMap() => Map.unmodifiable(_env);

  Future<void> load([filePath = '.app_env']) {
    return rootBundle.loadStructuredData(filePath, (fileStr) async {
      _env.addAll(dotenv.Parser().parse(fileStr.split('\n')));
    });
  }

  @override
  String toString() => _env.toString();
}
