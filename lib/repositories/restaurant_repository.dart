import 'package:dio/dio.dart';
import 'package:restaurantour/core/queries.dart';
import 'package:restaurantour/models/dto.dart';

class RestaurantRepository {
  final Dio dio;

  RestaurantRepository({required this.dio});

  Future<RestaurantQueryResultDto?> getRestaurants({int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getRestaurantsQuery(offset),
    );
    return RestaurantQueryResultDto.fromJson(response.data!['data']['search']);
  }

  Future<ReviewQueryResultDto?> getReviews({required String restaurantId, int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getReviewsQuery(restaurantId: restaurantId, offset: offset),
    );
    final result = response.data!['data']['reviews'];

    return ReviewQueryResultDto.fromJson(result);
  }

  Future<RestaurantDto> getRestaurantDetails({required String restaurantId, int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getRestaurantDetailsQuery(restaurantId: restaurantId),
    );
    final result = response.data!['data']['business'];
    return RestaurantDto.fromJson(result);
  }

  Future<RestaurantDto> getSingleRestaurant({required String restaurantId, int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: RTQueries.getSingleRestaurantQuery(restaurantId: restaurantId),
    );
    final result = response.data!['data']['business'];
    return RestaurantDto.fromJson(result);
  }
}
