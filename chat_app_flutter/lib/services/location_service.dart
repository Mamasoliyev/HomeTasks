import 'package:location/location.dart';

class LocationService {
  // location classdan instance olamiz ishlatish uchun
  Location location = Location();

  // location service enable(ruxsat) berilgan
  bool? serviceEnabled;

  // location olish uchun permission berilgannmi
  PermissionStatus? permissionGranted;

  // location ma'lumot
  LocationData? locationData;

  Future<void> isServiceEnabled() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled!) {
        return;
      }
    }
  }

  Future<void> askPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<LocationData> getLocation() async {
    await isServiceEnabled();
    await askPermission();
    locationData = await location.getLocation();
    return locationData!;
  }
}
