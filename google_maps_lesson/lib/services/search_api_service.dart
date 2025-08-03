import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesService {
  final String apiKey =
      'AIzaSyB_frTQZpLcjRODMaCXv83J6In-k02OO4s'; // Google Maps API kalitini qo‘ying
  final String baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  final String detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  final String directionsUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  // Joylashuvlarni qidirish (Autocomplete)
  Future<List<Map<String, dynamic>>> searchPlaces(
    String query, {
    required bool Function() isCancelled,
  }) async {
    if (query.isEmpty || isCancelled()) return [];

    final url = '$baseUrl?input=$query&key=$apiKey&language=uz';
    final response = await http.get(Uri.parse(url));

    if (isCancelled()) return [];

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return List<Map<String, dynamic>>.from(data['predictions']);
      }
    }
    return [];
  }

  // Joylashuv detallarini olish
  Future<Map<String, dynamic>?> getPlaceDetails(
    String placeId, {
    required bool Function() isCancelled,
  }) async {
    if (isCancelled()) return null;

    final url = '$detailsUrl?place_id=$placeId&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (isCancelled()) return null;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return data['result'];
      }
    }
    return null;
  }

  // Yo‘nalish olish (Directions API)
  Future<List<LatLng>?> getRoute(
    LatLng origin,
    LatLng destination, {
    required bool Function() isCancelled,
  }) async {
    if (isCancelled()) return null;

    final url =
        '$directionsUrl?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey&mode=driving&language=uz';
    final response = await http.get(Uri.parse(url));

    if (isCancelled()) return null;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final points = data['routes'][0]['overview_polyline']['points'];
        return _decodePolyline(points);
      }
    }
    return null;
  }

  // Polilayn dekod qilish
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
