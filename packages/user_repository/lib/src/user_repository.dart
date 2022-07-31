import 'dart:async';
import 'package:collection/collection.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

/// {@template user_repository}
/// User Repository
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository();

  /// Provides a [Stream] of all favorite restaurants
  Stream<List<Restaurant>> get favoriteRestaurants async* {
    yield* _favoriteRestaurantsController.stream;
  }

  /// Add restaurant to favorites list.
  void addFavoriteRestaurant(Restaurant restaurant) {
    final duplicate = _favoriteRestaurants
        .firstWhereOrNull((element) => element.id == restaurant.id);
    if (duplicate == null) {
      _favoriteRestaurants.add(restaurant);
      _favoriteRestaurantsController.add([..._favoriteRestaurants]);
    }
  }

  /// Remove a restaurant from the list of favorites with the given
  /// restaurantId.
  void removeFavoriteRestaurant(String restaurantId) {
    _favoriteRestaurants.removeWhere((element) => restaurantId == element.id);
    _favoriteRestaurantsController.add([..._favoriteRestaurants]);
  }

  final _favoriteRestaurantsController =
      StreamController<List<Restaurant>>.broadcast();
  final List<Restaurant> _favoriteRestaurants = [];
}
