import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  static const String _key = 'saved_locations';

  // Saqlash
  static Future<void> saveLocation(double lat, double lng, String promt) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> locations = prefs.getStringList(_key) ?? [];

    final locationMap = {
      'lat': lat,
      'lng': lng,
    };

    locations.add(jsonEncode(locationMap));
    await prefs.setStringList(_key, locations);
  }

  // Olish
  static Future<List<Map<String, dynamic>>> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> locations = prefs.getStringList(_key) ?? [];

    return locations.map((loc) {
      final decoded = jsonDecode(loc);
      return {
        'promt': decoded['promt'] ?? 'topilmadi',
        'lat': decoded['lat'],
        'lng': decoded['lng'],
      };
    }).toList();
  }

  // Tozalash (agar kerak bo‘lsa)
  static Future<void> clearLocations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
