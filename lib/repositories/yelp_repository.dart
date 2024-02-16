import 'package:restaurantour/models/restaurant.dart';

abstract class YelpRepository {
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0});
}
