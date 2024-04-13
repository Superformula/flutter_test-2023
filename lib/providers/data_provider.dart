import 'package:flutter/foundation.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class DataProvider extends ChangeNotifier {
  List<Restaurant> restaurants = [];

  Future<String?> getRestaurants() async {
    try {
      var result = await YelpRepository().getRestaurants();
      print("Result: $result");
      if (result != null) {
        restaurants.clear();
        restaurants.addAll(result.restaurants ?? []);
      }
      notifyListeners();
      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
