import 'package:dio/dio.dart';
import 'package:restaurantour/core/queries.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantRepository {
  final Dio dio;

  RestaurantRepository({required this.dio});

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getRestaurantsQuery(offset),
    );
    return RestaurantQueryResult.fromJson(response.data!['data']['search']);
  }

  Future<List<Review>> getReviews({required String restaurantId, int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getReviewsQuery(restaurantId: restaurantId, offset: offset),
    );
    final result = response.data!['data']['reviews']['review'];
    if (result is List) {
      return result.map((json) => Review.fromJson(json)).toList();
    }
    return [];
  }

  Future<Restaurant> getRestaurantDetails({required String restaurantId, int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getRestaurantDetailsQuery(restaurantId: restaurantId),
    );
    final result = response.data!['data']['business'];

    return Restaurant.fromJson(result);
  }
}
