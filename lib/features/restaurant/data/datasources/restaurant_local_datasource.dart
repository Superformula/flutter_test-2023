import 'package:hive/hive.dart';

class RestaurantLocalDatasource {
  Future<Map> fetchFavoriteRestaurants() async {
    final favoriteRestaurantsBox = await _openFavoriteRestaurantsBox();

    return favoriteRestaurantsBox.toMap();
  }

  Future<void> addFavoriteRestaurant(String? id, Map restaurantData) async {
    final favoriteRestaurantsBox = await _openFavoriteRestaurantsBox();

    return await favoriteRestaurantsBox.put(id, restaurantData);
  }

  Future<void> deleteFavoriteRestaurant(String? id) async {
    final favoriteRestaurantsBox = await _openFavoriteRestaurantsBox();

    return await favoriteRestaurantsBox.delete(id);
  }

  Future<Box> _openFavoriteRestaurantsBox() =>
      Hive.openBox('favoriteRestaurants');
}
