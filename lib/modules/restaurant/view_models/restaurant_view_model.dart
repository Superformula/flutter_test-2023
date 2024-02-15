import 'package:stacked/stacked.dart';

import '../../../common/shared_pref_helper.dart';
import '../../../models/restaurant.dart';
import '../../../repositories/yelp_repository.dart';

class RestaurantViewModel extends BaseViewModel {
  final YelpRepository yelpRepo;
  final SharedPreferencesHelper sharedPrefHelper =
      SharedPreferencesHelper.instance;

  List<Restaurant> restaurants = [];
  String? errorMessage;

  RestaurantViewModel({required this.yelpRepo});

  Future<void> ready() async {
    setBusy(true);
    var cachedRestaurants = await sharedPrefHelper.getRestaurants();
    if (cachedRestaurants.isNotEmpty) {
      restaurants = cachedRestaurants;
    } else {
      await fetchAndCacheRestaurants();
    }
    setBusy(false);
  }

  Future fetchAndCacheRestaurants() async {
    try {
      var response = await yelpRepo.getRestaurants();
      if (response!.restaurants!.isNotEmpty) {
        restaurants = response.restaurants!;
        await sharedPrefHelper.cacheRestaurants(restaurants);
      }
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
