import 'package:hive/hive.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

abstract class LocalRestaurantDataSource {
  Future<List<Restaurant>> getFavoriteRestaurants();
  Future<void> insertFavoriteRestaurant(Restaurant restaurant);
  Future<void> deleteFavoriteRestaurant(Restaurant restaurant);
}

class LocalRestaurantDataSourceImpl extends LocalRestaurantDataSource {
  static const _favoriteBoxName = 'favorite_restaurants';
  LocalRestaurantDataSourceImpl();

  @override
  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final box = Hive.box<Restaurant>(_favoriteBoxName);
    return box.values.toList();
  }

  @override
  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    Hive.box<Restaurant>(_favoriteBoxName).add(
      restaurant,
    );
  }

  @override
  Future<void> deleteFavoriteRestaurant(Restaurant restaurant) async {
    final box = Hive.box<Restaurant>(_favoriteBoxName);
    final index = box.values
        .toList()
        .indexWhere((element) => element.id == restaurant.id);
    box.deleteAt(index);
  }
}
