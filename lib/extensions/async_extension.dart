import 'package:flutter/cupertino.dart';
import 'package:restaurantour/models/restaurant.dart';

// Check has restaurant data from API.
extension RestaurantAsync<T> on AsyncSnapshot<T> {
  bool hasRestaurantData() {
    if (hasData) {
      List<Restaurant>? restaurants = (data! as RestaurantQueryResult).restaurants;
      if (restaurants != null) {
        if (restaurants.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }
}