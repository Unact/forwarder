import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

import 'package:forwarder/app/app.dart';
import 'package:forwarder/config/app_config.dart';
import 'package:forwarder/config/app_env.dart' show appEnv;

void main() async {
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;
  String developmentUrl;
  String osVersion;
  String deviceModel;
  bool isPhysicalDevice;
  bool development = false;
  assert(development = true); // Метод выполняется только в debug режиме

  // If you're running an application and need to access the binary messenger before `runApp()` has been called (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    developmentUrl = 'http://localhost:3000';
    iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    isPhysicalDevice = iosDeviceInfo.isPhysicalDevice;
    osVersion = iosDeviceInfo.systemVersion;
    deviceModel = iosDeviceInfo.utsname.machine;
  } else {
    developmentUrl = 'http://10.0.2.2:3000';
    androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    isPhysicalDevice = androidDeviceInfo.isPhysicalDevice;
    osVersion = androidDeviceInfo.version.release;
    deviceModel = androidDeviceInfo.brand + ' - ' + androidDeviceInfo.model;
  }

  await appEnv.load();

  App.setup(AppConfig(
    packageInfo: await PackageInfo.fromPlatform(),
    isPhysicalDevice: isPhysicalDevice,
    deviceModel: deviceModel,
    osVersion: osVersion,
    env: development ? 'development' : 'production',
    databaseVersion: 2,
    apiBaseUrl: '${development ? developmentUrl : 'https://rapi.unact.ru'}/api/',
    sentryDsn: appEnv['SENTRY_DSN']
  )).run();
}
