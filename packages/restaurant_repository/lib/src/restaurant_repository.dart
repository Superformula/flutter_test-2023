import 'dart:async';

import 'package:yelp_api/yelp_api.dart' hide Restaurant, Review, User;

import 'models/models.dart';

/// {@template restaurant_exception}
/// Generic exception thrown by the [RestaurantRepository].
/// {@endtemplate}
class RestaurantException implements Exception {
  /// {@macro thesaurus_exception}
  const RestaurantException(this.exception, {required this.stackTrace});

  /// The exception that occured.
  final dynamic exception;

  /// The [StackTrace] for the exception.
  final StackTrace stackTrace;
}

/// {@template restaurant_http_request_failure}
/// Thrown when an error occurs while performing a search.
/// {@endtemplate}
class RestaurantHttpRequestFailure extends RestaurantException {
  /// {@macro restaurant_http_request_failure}
  RestaurantHttpRequestFailure(
    HttpRequestFailure failure,
    StackTrace stackTrace,
  ) : super(failure, stackTrace: stackTrace);
}

/// {@template restaurant_repository}
/// A repository that handles restaurant related requests.
/// {@endtemplate}
class RestaurantRepository {
  /// {@macro restaurant_repository}
  RestaurantRepository({required YelpApi yelpApi}) : _yelpApi = yelpApi;
  final YelpApi _yelpApi;
  final _restaurantsController = StreamController<List<Restaurant>>.broadcast();
  final List<Restaurant> _restaurants = [];
  Stream<List<Restaurant>> get restaurants async* {
    yield* _restaurantsController.stream;
  }

  Future<void> getRestaurants() async {
    RestaurantQueryResult? restaurantQueryResult;
    try {
      restaurantQueryResult =
          await _yelpApi.getRestaurants(offset: _restaurants.length);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw RestaurantHttpRequestFailure(e, stackTrace);
    }

    if (restaurantQueryResult?.restaurants != null) {
      final restaurants = _convertQueryToRestaurantList(restaurantQueryResult!);
      _restaurants.addAll(restaurants);
      _restaurantsController.add([..._restaurants]);
    }
  }

  List<Restaurant> _convertQueryToRestaurantList(
    RestaurantQueryResult restaurantQueryResult,
  ) {
    return restaurantQueryResult.restaurants!
        .map(
          (restaurant) => Restaurant(
            id: restaurant.id,
            name: restaurant.name,
            price: restaurant.price,
            rating: restaurant.rating,
            photoUrl: restaurant.heroImage,
            category: restaurant.displayCategory,
            isOpenNow: restaurant.isOpen,
            reviews: restaurant.reviews
                ?.map(
                  (review) => Review(
                    id: review.id,
                    rating: review.rating,
                    user: review.user == null
                        ? null
                        : User(
                            id: review.user?.id,
                            imageUrl: review.user?.imageUrl,
                            name: review.user?.name,
                          ),
                  ),
                )
                .toList(),
            address: restaurant.location?.formattedAddress,
          ),
        )
        .toList();
  }
}
