import 'package:flutter/foundation.dart';
import 'package:restaurantour/main.dart';

import 'package:restaurantour/models/restaurant.dart';

class RestaurantsManager {
  final restaurants = ValueNotifier<RestaurantQueryResult?>(
    const RestaurantQueryResult(),
  );

  void getRestaurants() async {
    restaurants.value = await yelpService.getRestaurants();
  }
}
