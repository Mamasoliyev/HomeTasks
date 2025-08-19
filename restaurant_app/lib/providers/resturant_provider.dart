import 'package:flutter/material.dart';
import 'package:food_app/services/resturant_service.dart';

class RestaurantProvider with ChangeNotifier {
  List<Map<String, dynamic>> _restaurants = [];
  bool _loading = false;

  List<Map<String, dynamic>> get restaurants => _restaurants;
  bool get loading => _loading;

  final RestaurantService _service = RestaurantService();

  Future<void> loadRestaurants() async {
    _loading = true;
    notifyListeners();

    _restaurants = await _service.fetchRestaurants();

    _loading = false;
    notifyListeners();
  }
}
