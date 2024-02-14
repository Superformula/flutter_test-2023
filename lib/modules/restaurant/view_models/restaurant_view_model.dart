import 'package:restaurantour/models/restaurant.dart';
import 'package:stacked/stacked.dart';

import '../../../repositories/yelp_repository.dart';

class RestaurantViewModel extends BaseViewModel {
  YelpRepository yelpRepo;

  Set<String> _favoriteRestaurantIds = {};
  Set<String> get favoriteRestaurantIds => _favoriteRestaurantIds;

  List<Restaurant>? restaurants;

  RestaurantViewModel({required this.yelpRepo});

  ready() async {}

  Future<List<Restaurant>> fetchData() async {
    try {
      final result = await yelpRepo.getRestaurants();
      return result!.restaurants!;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> toggleFavorite(String restaurantId) async {
    if (_favoriteRestaurantIds.contains(restaurantId)) {
      _favoriteRestaurantIds.remove(restaurantId);
    } else {
      _favoriteRestaurantIds.add(restaurantId);
    }
    notifyListeners();

    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('favorites', _favoriteRestaurantIds.toList());
  }

  bool isFavorite(String restaurantId) =>
      _favoriteRestaurantIds.contains(restaurantId);
}
