import 'package:geolocator/geolocator.dart';

final Geolocator geolocator = Geolocator();

Future<Position?> getCurrentLocation() async {
  final permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    final per = await Geolocator.requestPermission();
    if (per != LocationPermission.always) {
      return null;
    }
  }

  final Position position = await Geolocator.getCurrentPosition();
  return position;
}
