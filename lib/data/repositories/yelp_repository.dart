import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:restaurantour/data/models/restaurant.dart';

const _apiKey =
    'X-Me22MBBw6lIYs9fV-ntllINQ_8rfQXuHojnDY8UxXUpuSR0zHY5TSaPmyKY8qwqirh2LWdew6yjgxPSk2eiPWA77TgJHXRC4En1JJ0Kn2ej0vNHBTsuDfLVKMZZnYx';

class MockResponse {
  final Map<String, dynamic> data;
  MockResponse(this.data);
}

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
      final response = await mockRestaurantsResponse();

      // dio.post<Map<String, dynamic>>(
      //   '/v3/graphql',
      //   data: _getQuery(offset),
      // );

      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    }
  }

  Future<MockResponse> mockRestaurantsResponse() async {
    await Future.delayed(const Duration(seconds: 2));
    final jsonString =
        await rootBundle.loadString('assets/yelp_restaurants_response.json');
    return MockResponse(jsonDecode(jsonString));
  }

  Future<RestaurantQueryResult?> getRestaurantReviews({int offset = 0}) async {
    try {
      final response = await mockRestaurantReviewsResponse();

      // dio.post<Map<String, dynamic>>(
      //   '/v3/graphql',
      //   data: _getReviewsQuery(offset),
      // );

      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    }
  }

  Future<MockResponse> mockRestaurantReviewsResponse() async {
    await Future.delayed(const Duration(seconds: 2));
    final jsonString =
        await rootBundle.loadString('assets/yelp_reviews_response.json');
    return MockResponse(jsonDecode(jsonString));
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

  String _getReviewsQuery(int offset) {
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
