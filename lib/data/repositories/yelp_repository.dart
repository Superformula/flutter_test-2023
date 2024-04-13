import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/data/models/restaurant.dart';

const _apiKey =
    'X-Me22MBBw6lIYs9fV-ntllINQ_8rfQXuHojnDY8UxXUpuSR0zHY5TSaPmyKY8qwqirh2LWdew6yjgxPSk2eiPWA77TgJHXRC4En1JJ0Kn2ej0vNHBTsuDfLVKMZZnYx';

class YelpRepository {
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

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );
      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } catch (e) {
      return null;
    }
  }

  String _getQuery(int offset) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: 20, offset: $offset) {
    total    
    business {
      id
      name
      price
      rating
      photos
      reviews {
        id
        rating
        user {
          id
          image_url
          name
        }
      }
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
  }
''';
  }
}
