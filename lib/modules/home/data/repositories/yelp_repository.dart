import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/core/utils/custom_logger.dart';

import '../../domain/repositories/restaurant_repository_interface.dart';
import '../models/response_model.dart';
import '../models/restaurant.dart';

const _apiKey =
    'HDxFOxQoKoxRd7KjdBYPJLLlhXYL8yxvCMfFcMA8LuoSDjJt6ewkz1xzeP2qMNNDN7Gp6i6FdQ9qoWepPT1YOPmIGurrEQDdbQWe8psY8NstpcJvFzy52Kd9z4EaZnYx';

// const _apiKey =
//     'zbRXVjMzE2j_KmW9SWAyeiSCMc7WGO5HZ4u9yuWGd-VdTmLd9Wwk5Q8wENb1JU-7O8-PYrk9cNF-gDKBDrxO4E_lnLHlz16LHD4P_5_HXvwX7btbgf3kGV4EkfQaZnYx';

class YelpRepository implements IRestaurantRepository {
  late Dio dio;

  YelpRepository({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer $_apiKey',
                  'Content-Type': 'application/graphql',
                },
              ),
            );

  @override
  Future<ResponseModel<List<Restaurant>, Exception>> getRestaurants({int offset = 0}) async {
    try {
      final String query = '''
            query getRestaurants {
              search(location: "Las Vegas",limit: 20, offset: $offset) {
                total    
                business {
                  id
                  name
                  price
                  rating
                  photos
                  hours {
                    is_open_now
                  }
                }
              }
            }
      ''';

      final response = await dio.post<Map<String, dynamic>>('/v3/graphql', data: query);
      final result = RestaurantQueryResult.fromJson(response.data!['data']['search']);
      return ResponseModel(data: result.restaurants ?? <Restaurant>[]);
    } on DioException catch (e) {
      if (e.message?.contains('Beta') ?? false) {
        return ResponseModel(data: []);
      }
      return ResponseModel(error: Exception('Error on request when get restaurants'));
    } catch (e, s) {
      LoggerApp.error('Error on get restaurants', e, s);
      return ResponseModel(error: Exception('Error on get restaurants'));
    }
  }

  @override
  Future<ResponseModel<Restaurant, Exception>> getRestaurantById({required String id}) async {
    try {
      final String query = '''
            query getRestaurantById {
              business(id: "$id") {
                id
                name
                price
                photos
                rating
                review_count
                categories {
                  alias
                  title
                }
                hours {
                  is_open_now
                }
                location {
                  formatted_address
                }
                reviews {
                  id
                  rating
                  text
                  user {
                    id
                    image_url
                    name
                  }
                }
              }
            }
      ''';

      final response = await dio.post<Map<String, dynamic>>('/v3/graphql', data: query);
      final data = Restaurant.fromJson(response.data!['data']['business']);
      return ResponseModel(data: data);
    } catch (e, s) {
      LoggerApp.error('Error on get restaurant by id', e, s);
      return ResponseModel(error: Exception('Error on get restaurant by id'));
    }
  }
}
