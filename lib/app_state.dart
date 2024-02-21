import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;
  set favorites(List<Restaurant> options) {
    _favorites = options;
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) {
    if (isFavorite(restaurant)) return;
    _favorites.add(restaurant);
    notifyListeners();
  }

  void removeFavorite(Restaurant restaurant) {
    final index = _favorites.indexWhere((element) => element.id == restaurant.id);
    _favorites.removeAt(index);
    notifyListeners();
  }

  bool isFavorite(Restaurant? restaurant) {
    if (restaurant == null) return false;
    final index = _favorites.indexWhere((element) => element.id == restaurant.id);
    return index != -1;
  }
}
