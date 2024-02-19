import '../../core/error/failures.dart';
import '../models/restaurant.dart';

abstract interface class RestaurantsRepository {
  Future<(List<Restaurant>?, RestaurantListFailure?)> getRestaurants({int offset = 0});

  Future<(Restaurant?, RestaurantDetailsFailure?)> getRestaurantDetails(String id);

  Future<(List<Restaurant>?, FavoriteRestaurantsFailure?)> getFavoriteRestaurants();

  Future<(void, FavoriteRestaurantsFailure?)> addFavoriteRestaurant(Restaurant restaurant);
}
