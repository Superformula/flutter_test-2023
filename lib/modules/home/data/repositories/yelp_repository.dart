import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/core/utils/custom_logger.dart';

import '../../domain/errors/erros.dart';
import '../../domain/repositories/restaurant_repository_interface.dart';
import '../models/response_model.dart';
import '../models/restaurant.dart';

/// ! In a real application, I usually use String.fromEnvironment to get keys for security,
/// ! but in this test I will leave it here to help you test my code
const _apiKey =
    'zbRXVjMzE2j_KmW9SWAyeiSCMc7WGO5HZ4u9yuWGd-VdTmLd9Wwk5Q8wENb1JU-7O8-PYrk9cNF-gDKBDrxO4E_lnLHlz16LHD4P_5_HXvwX7btbgf3kGV4EkfQaZnYx';

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
      /// When you reach the limit of requests in the api
      if ([400, 403].contains(e.response?.statusCode)) return ResponseModel(data: []);

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
      final business = response.data?['data']?['business'];
      if (business == null) {
        return ResponseModel(error: NotFoundRestaurant());
      } else {
        final data = Restaurant.fromJson(response.data!['data']['business']);
        return ResponseModel(data: data);
      }
    } catch (e, s) {
      LoggerApp.error('Error on get restaurant by id', e, s);
      return ResponseModel(error: Exception('Error on get restaurant by id'));
    }
  }
}
