import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/errors/not_found_exception.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurants/restaurants_interface.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class RestaurantsRepository implements RestaurantsRepositoryInterface {
  RestaurantsRepository({
    required this.yelpRepository,
    required this.sharedPreferences,
  });

  final YelpRepository yelpRepository;
  final SharedPreferencesService sharedPreferences;

  @override
  Future<RestaurantQueryResult> getRestaurants() async {
    try {
      final result = await yelpRepository.getRestaurants();
      if (result != null) {
        return result;
      } else {
        throw NotFoundException();
      }
    } on NotFoundException {
      throw 'No restaurants found';
    } catch (e) {
      throw 'error: $e';
    }
  }
}
