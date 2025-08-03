import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<LatLng> getCurrentLocation() async {
    final location = Location();
    final hasPermission = await location.hasPermission();

    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }

    final locData = await location.getLocation();
    return LatLng(locData.latitude!, locData.longitude!);
  }
}
