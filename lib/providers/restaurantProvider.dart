import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class RestaurantProvider extends ChangeNotifier {
  final YelpRepository _repository = YelpRepository();
  List<Restaurant>? _restaurants;
  Set<String> _favorites = {};

  List<Restaurant>? get restaurants => _restaurants;

  Set<String> get favorites => _favorites;

  Future<void> fetchRestaurants() async {
    print('Fetching restaurants...');
    final result = await _repository.getRestaurants();
    if (result != null) {
      _restaurants = result.restaurants;
      notifyListeners();
    }
  }

  List<Restaurant> getFavoriteRestaurants() {
    return _restaurants?.where((restaurant) {
          return _favorites.contains(restaurant.id);
        }).toList() ??
        [];
  }

  void toggleFavorite(String restaurantId, bool isFavorite) {
    if (isFavorite) {
      _favorites.add(restaurantId);
    } else {
      _favorites.remove(restaurantId);
    }

    notifyListeners();
  }
}
