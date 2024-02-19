import 'package:flutter/foundation.dart';
import 'package:restaurantour/main.dart';

import '../models/restaurant.dart';

class RestaurantsManager {
  final restaurantList = ValueNotifier<RestaurantQueryResult?>(
    const RestaurantQueryResult(),
  );

  Future<void> getRestaurants() async {
    restaurantList.value = await yService.getRestaurants();
  }
}
