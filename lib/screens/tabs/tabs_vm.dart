import 'package:flutter/cupertino.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

enum LoadStatus { loaded, loading, error }

class TabsVM extends ChangeNotifier {
  var _yelpRepository = YelpRepository();

  var loadStatus = LoadStatus.loading;

  List<Restaurant> restaurants = [];
  List<Restaurant> favoriteRestaurants = [];

  Future<void> getRestaurants() async {
    try {
      restaurants.clear();

      final response = await _yelpRepository.getRestaurants();
      loadStatus = LoadStatus.loaded;

      restaurants = response?.restaurants ?? [];
      await getFavoriteRestaurants();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      loadStatus = LoadStatus.error;
      notifyListeners();
    }
  }

  Future<void> getFavoriteRestaurants() async {
    favoriteRestaurants.clear();

    try {
      final restaurantIds = await _yelpRepository.getFavoriteRestaurantsIds();

      for (var restaurant in restaurants) { 
        if (restaurantIds.contains(restaurant.id)) {
          favoriteRestaurants.add(restaurant);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void forceNotifyListeners() {
    notifyListeners();
  }

  @visibleForTesting
  void setYelpRepository(YelpRepository repository) {
    _yelpRepository = repository;
  }
}
