import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

/// {@template user_repository}
/// User Repository
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository();

  /// Provides a [Stream] of all favorite restaurants
  Stream<List<Restaurant>> get favorites async* {
    yield* _favoriteRestaurantsController.stream;
  }

  /// Add restaurant to favorites list.
  void addFavoriteRestaurant(Restaurant restaurant) {
    final duplicate = favoriteRestaurants
        .firstWhereOrNull((element) => element.id == restaurant.id);
    if (duplicate == null) {
      favoriteRestaurants.add(restaurant);
      _favoriteRestaurantsController.add([...favoriteRestaurants]);
    }
  }

  /// Remove a restaurant from the list of favorites with the given
  /// restaurantId.
  void removeFavoriteRestaurant(String restaurantId) {
    favoriteRestaurants.removeWhere((element) => restaurantId == element.id);
    _favoriteRestaurantsController.add([...favoriteRestaurants]);
  }

  bool isFavorite(String restaurantId) {
    return favoriteRestaurants.any((element) => restaurantId == element.id);
  }

  final _favoriteRestaurantsController =
      StreamController<List<Restaurant>>.broadcast();
  @visibleForTesting
  final List<Restaurant> favoriteRestaurants = [];
}
