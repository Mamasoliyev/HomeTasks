import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _books = [];

  List<Map<String, dynamic>> get bookedRestaurants => _books;

  void addRestaurant(Map<String, dynamic> restaurant) {
    if (!_books.any((r) => r['id'] == restaurant['id'])) {
      _books.add(restaurant);
      notifyListeners();
    }
  }

  void removeRestaurant(Map<String, dynamic> restaurant) {
    _books.removeWhere((r) => r['id'] == restaurant['id']);
    notifyListeners();
  }
}
