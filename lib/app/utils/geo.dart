import 'dart:async';

import 'package:forwarder/app/entities/entities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

class Geo {
  static Future<Position> getCurrentPosition() async {
    if (!(await Permissions.hasLocationPermissions())) throw AppError('Нет прав на получение местоположения');
    if (!(await Geolocator.isLocationServiceEnabled())) throw AppError('Выключено определение местоположения');

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(timeLimit: Duration(seconds: 10))
      );

      // FIX
      // Some returned values can be NaN or Infinity
      return Position(
        longitude: position.longitude.isFinite ? position.longitude : 0,
        latitude: position.latitude.isFinite ? position.latitude : 0,
        timestamp: position.timestamp,
        accuracy: position.accuracy.isFinite ? position.accuracy : -1,
        altitude: position.altitude.isFinite ? position.altitude : 0,
        altitudeAccuracy: position.altitudeAccuracy.isFinite ? position.altitudeAccuracy : -1,
        heading: position.heading.isFinite ? position.heading : 0,
        headingAccuracy: position.headingAccuracy.isFinite ? position.headingAccuracy : -1,
        speed: position.speed.isFinite ? position.speed : 0,
        speedAccuracy: position.speedAccuracy.isFinite ? position.speedAccuracy : -1
      );
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
