import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/local_db.dart';

class RestaurantHandler {
  List<Restaurant> restaurants = [];
  Failure? error;

  RestaurantHandler({List<Restaurant>? restaurants}) {
    if (restaurants != null) {
      this.restaurants = restaurants;
    }
  }

  requestRestaurant() async {
    var response = await RestaurantService.getRestaurants();
    if (response is Success) {
      restaurants = response.response as List<Restaurant>;
      if (error != null) error = null;
      await LocalDB.instance.saveRestaurants(restaurants);
    }
    if (response is Failure) {
      error = response;
    }
  }
}
