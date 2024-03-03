import 'dart:async';

import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is the implementation of the [SharedPreferencesRepository] interface.
/// It uses the [SharedPreferences] package to store the favorite restaurants.

class SharedPreferencesSource extends SharedPreferencesRepository {
  static const _key = 'favorite_restaurants';

  final StreamController<List<String>> _controller =
      StreamController.broadcast();

  @override
  Future<List<String>> getFavoriteRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> toggleFavoriteRestaurant(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRestaurants = prefs.getStringList(_key) ?? [];
    if (favoriteRestaurants.contains(restaurantId)) {
      favoriteRestaurants.remove(restaurantId);
    } else {
      favoriteRestaurants.add(restaurantId);
    }
    await prefs.setStringList(_key, favoriteRestaurants);
    _controller.add(favoriteRestaurants);
  }

  @override
  Stream<List<String>> watchFavoriteRestaurants() {
    _controller.addStream(Stream.fromFuture(getFavoriteRestaurants()));
    return _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
