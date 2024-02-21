import '../../core/error/failures.dart';
import '../models/restaurant.dart';

abstract interface class RestaurantsRepository {
  Future<(List<Restaurant>?, RestaurantListFailure?)> getRestaurants({int offset = 0});

  Future<(Restaurant?, RestaurantDetailsFailure?)> getRestaurantDetails(String id);

  Future<(List<Restaurant>?, FavoriteRestaurantsFailure?)> getFavoriteRestaurants();

  Future<(void, FavoriteRestaurantFailure?)> addFavoriteRestaurant(String id);

  Future<bool> checkIfItIsFavoriteRestaurant(String id);
}
