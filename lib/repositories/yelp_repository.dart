import 'package:flutter/foundation.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'yelp_data_provider.dart';

class YelpRepository {
  YelpRepository({
    @visibleForTesting YelpDataProvider? yelpDataProvider,
  }) : yelpDataProvider = yelpDataProvider ?? YelpDataProvider();

  final YelpDataProvider yelpDataProvider;

  Future<List<Restaurant>?> getRestaurants({int offset = 0}) async {
    var restaurantQueryResult =
        await yelpDataProvider.getRestaurants(offset: offset);
    return restaurantQueryResult?.restaurants;
  }
}
