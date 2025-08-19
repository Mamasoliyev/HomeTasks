// services/restaurant_service.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantLocationService {
  static final Map<String, LatLng> restaurants = {
    "Oqtepa Lavash - Chilonzor": LatLng(41.2856, 69.2034),
    "Evos - Mirzo Ulug'bek": LatLng(41.3385, 69.3342),
    "Black Star Burger - Center": LatLng(41.3116, 69.2790),
    "KFC - Samarqand Darvoza": LatLng(41.3022, 69.2482),
    "Bukhara Restaurant - Yunusobod": LatLng(41.3532, 69.2867),
  };
}
