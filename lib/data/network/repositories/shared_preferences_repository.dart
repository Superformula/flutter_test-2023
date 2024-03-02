import 'dart:async';

import 'package:restaurantour/domain/restaurants/repository_interfaces/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [PreferencesRepository] implementation that uses [SharedPreferences] as the
/// underlying storage.
///
/// Should be replaced with a more robust solution in a production environment.

class SharedPreferencesRepository extends PreferencesRepository {
  static const _key = 'favorite_restaurants';

  final StreamController<List<String>> _controller =
      StreamController.broadcast();

  @override
  Future<List<String>> getFavoriteRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addFavoriteRestaurant(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    if (!favorites.contains(restaurantId)) {
      favorites.add(restaurantId);
      await prefs.setStringList(_key, favorites);
    }
  }

  @override
  Stream<List<String>> watchFavoriteRestaurants() {
    return _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
