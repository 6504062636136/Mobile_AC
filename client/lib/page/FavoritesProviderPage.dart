import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> item) {
    final existingIndex =
        _favorites.indexWhere((favItem) => favItem['name'] == item['name']);

    if (existingIndex != -1) {
      _favorites.removeAt(existingIndex); // ลบออกจาก Favorite
    } else {
      _favorites.add(item); // เพิ่มเข้า Favorite
    }

    notifyListeners();
  }

  bool isFavorite(String name) {
    return _favorites.any((favItem) => favItem['name'] == name);
  }
}
