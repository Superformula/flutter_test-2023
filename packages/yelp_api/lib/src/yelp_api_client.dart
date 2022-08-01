import 'package:yelp_api/yelp_api.dart';

/// {@template yelp_api}
/// The interface for a Yelp API that provides access to
/// restaurants data.
/// {@endtemplate}
abstract class YelpApi {
  /// {@macro yelp_api}
  const YelpApi();

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0});
  Future<Restaurant> getRestaurant(String restaurantId);
}
