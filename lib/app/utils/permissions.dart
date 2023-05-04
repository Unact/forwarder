import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> hasBluetoothPermission() async {
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
      ].request();

      return statuses.values.every((element) => element.isGranted);
    }

    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothConnect,
        Permission.bluetoothScan
      ].request();

      return statuses.values.every((element) => element.isGranted);
    }

    return false;
  }
}
