import 'package:flutter/foundation.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class DataProvider extends ChangeNotifier {
  Future<String?> getRestaurants() async {
    try {
      var result = await YelpRepository().getRestaurants();
      print(result);
      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
