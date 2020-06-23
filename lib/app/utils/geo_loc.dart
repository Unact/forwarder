import 'package:location/location.dart';

class GeoLoc {
  static Future<Map<String, dynamic>> getCurrentLocation() async {
    Location loc = new Location();

    if (!(await loc.serviceEnabled()) && !(await loc.requestService())) {
      return null;
    }

    if (
      await loc.hasPermission() == PermissionStatus.denied &&
      await loc.requestPermission() != PermissionStatus.granted
    ) {
      return null;
    }

    LocationData data = await loc.getLocation();

    return {
      'latitude': data.latitude,
      'longitude': data.longitude,
      'accuracy': data.accuracy,
      'altitude': data.altitude,
      'heading': data.heading,
      'speed': data.speed,
      'point_ts': DateTime.fromMillisecondsSinceEpoch(data.time.toInt()).toIso8601String()
    };
  }
}
