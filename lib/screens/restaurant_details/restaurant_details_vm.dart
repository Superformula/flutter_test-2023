import 'package:flutter/cupertino.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantDetailsVM extends ChangeNotifier {
  Restaurant? restaurant;

  bool get showReviews => restaurant?.reviews?.isNotEmpty ?? false;

  late final _prefs = SharedPreferences.getInstance();

  var _yelpRepository = YelpRepository();

  void init(Restaurant restaurant) async {
    this.restaurant = restaurant;
  }

  Future<void> toggleFavorite() async {
    final restaurantIds = await _yelpRepository.getFavoriteRestaurantsIds();
    final restaurantId = restaurant?.id;

    if (restaurantId != null) {
      if (await isFavorite()) {
        restaurantIds.remove(restaurantId);
      } else {
        restaurantIds.add(restaurantId);
      }
      await _yelpRepository.setFavoriteRestaurantsIds(restaurantIds);
      notifyListeners();
    }
  }

  Future<bool> isFavorite() async {
    final prefs = await _prefs;
    final restaurantsIds = prefs.getStringList(kFavoriteRestaurantsKey) ?? [];
    final restaurantId = restaurant?.id;

    if (restaurantId != null) {
      return restaurantsIds.contains(restaurantId);
    } else {
      return false;
    }
  }

  @visibleForTesting
  void setYelpRepository(YelpRepository repository) {
    _yelpRepository = repository;
  }
}
