import 'package:restaurantour/models/restaurant.dart';

abstract class RestaurantsRepositoryInterface {
  Future<RestaurantQueryResult> getRestaurants();
}
