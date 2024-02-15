import 'package:restaurantour/models/restaurant.dart';
import 'package:stacked/stacked.dart';

import '../../../repositories/yelp_repository.dart';

class RestaurantViewModel extends BaseViewModel {
  YelpRepository yelpRepo;
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
}
