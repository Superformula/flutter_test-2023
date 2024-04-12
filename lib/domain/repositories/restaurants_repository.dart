import 'package:restaurantour/data/models/restaurant.dart';

abstract class RestaurantsRepository {
  Future<RestaurantQueryResult?> getRestaurants();
}
