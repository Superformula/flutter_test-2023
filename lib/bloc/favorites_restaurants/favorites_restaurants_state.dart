import 'dart:convert';

import '../../models/restaurant.dart';

class FavoritesRestaurantsState {
  const FavoritesRestaurantsState(this.restaurants);

  final List<Restaurant> restaurants;

  static const empty = FavoritesRestaurantsState([]);

  String toJson() => json.encode(toMap());

  factory FavoritesRestaurantsState.fromJson(String source) =>
      FavoritesRestaurantsState.fromMap(json.decode(source));

  static const _key = 'my_favorites_state';

  Map<String, dynamic> toMap() {
    return {
      _key: restaurants.map((restaurant) => restaurant.toJson()).toList(),
    };
  }

  factory FavoritesRestaurantsState.fromMap(Map<String, dynamic>? map) {
    if (map == null) return empty;

    var restaurants = (map[_key] as List<dynamic>)
        .map((obj) => Restaurant.fromJson(obj))
        .toList();

    return FavoritesRestaurantsState(restaurants);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesRestaurantsState &&
          runtimeType == other.runtimeType &&
          restaurants == other.restaurants;

  @override
  int get hashCode => restaurants.hashCode;
}
