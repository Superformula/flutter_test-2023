import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';

abstract class RestaurantsRepository {
  Future<List<RestaurantEntity>> getRestaurants(int offset);
}
