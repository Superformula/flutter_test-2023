import 'package:yelp_api/yelp_api.dart';

/// {@template restaurant_repository}
/// A repository that handles restaurant related requests.
/// {@endtemplate}
class RestaurantRepository {
  /// {@macro restaurant_repository}
  const RestaurantRepository({required YelpApi yelpApi}) : _yelpApi = yelpApi;

  final YelpApi _yelpApi;

  Future<void> getRestaurants({int offset = 0}) async {
    final result = await _yelpApi.getRestaurants(offset: offset);
    print(result);
  }
}
