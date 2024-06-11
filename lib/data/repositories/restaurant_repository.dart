import 'package:restaurantour/data/datasources/restaurant_local_service.dart';
import 'package:restaurantour/data/datasources/restaurant_remote_service.dart';
import 'package:restaurantour/data/models/restaurant.dart';

class RestaurantRepository {
  const RestaurantRepository(this._remoteService, this._localService);

  final RestaurantRemoteService _remoteService;
  final RestaurantLocalService _localService;

  Future<List<Restaurant>?> fetchRestaurants() async {
    final query = await _remoteService.getRestaurants();
    return query?.restaurants;
  }
  bool favoriteRestaurant(
    String id, {
    required bool favorite,
  }) {
    return _localService.favoriteRestaurant(id, favorite: favorite);
  }

  bool checkFavoriteRestaurant(String id) {
    return _localService.checkFavoriteRestaurant(id);
  }
}
