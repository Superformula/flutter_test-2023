import 'dart:convert';

import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  FavoritesRepository();

  List<Restaurant> loadFavorites() {
    List<String>? result =
        sl<SharedPreferences>().getStringList('favoritesList');

    if (result != null) {
      Iterable l = result
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      return l.map((model) => Restaurant.fromJson(model)).toList();
    }
    return [];
  }

  Future<void> saveFavorites(List<Restaurant> favorites) async {
    List<String> favoriteStrings = favorites
        .map((restaurant) => json.encode(restaurant.toJson()))
        .toList();

    await sl<SharedPreferences>()
        .setStringList('favoritesList', favoriteStrings);
  }
}
