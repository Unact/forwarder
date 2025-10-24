import 'dart:async';

import 'package:forwarder/app/entities/entities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

class Geo {
  static Future<Position> getCurrentPosition() async {
    if (!(await Permissions.hasLocationPermissions())) throw AppError('Нет прав на получение местоположения');
    if (!(await Geolocator.isLocationServiceEnabled())) throw AppError('Выключено определение местоположения');

    try {
      return Geolocator.getCurrentPosition(locationSettings: LocationSettings(timeLimit: Duration(seconds: 10)));
    } on TimeoutException {
      return Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: -1,
        altitude: 0,
        altitudeAccuracy: -1,
        heading: 0,
        headingAccuracy: -1,
        speed: 0,
        speedAccuracy: -1
      );
    }
  }
}
