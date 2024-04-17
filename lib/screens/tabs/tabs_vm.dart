import 'package:flutter/cupertino.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

enum LoadStatus { loaded, loading, error }

class TabsVM extends ChangeNotifier {
  late final yelpRepository = YelpRepository();

  var loadStatus = LoadStatus.loading;

  List<Restaurant> restaurants = [];

  void getRestaurants() async {
    try {
      final response = await yelpRepository.getRestaurants();
      loadStatus = LoadStatus.loaded;

      restaurants = response?.restaurants ?? [];

      print(restaurants.toString());

      notifyListeners();
    } catch (e) {
      loadStatus = LoadStatus.error;
      notifyListeners();
    }
  }
}
