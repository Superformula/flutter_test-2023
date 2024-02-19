
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';

import '../../../main.dart';

abstract interface class RestaurantsRemoteDataSource {
  Future<RestaurantQueryResult> getRestaurants({int offset = 0});
}

/// Calls the Yelp Remote Data Source
///
/// Throws a [ServerException] in case of Exception.
///
class YelpRestaurantsRemoteDataSource implements RestaurantsRemoteDataSource {
  final Dio dio;

  YelpRestaurantsRemoteDataSource(this.dio);

  @override
  Future<RestaurantQueryResult> getRestaurants({int offset = 0}) async {
    try {
      // This if is only for saving yelp data usage
      if (jsonString.isNotEmpty && kDebugMode) {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        return RestaurantQueryResult.fromJson(jsonData['data']['search']);
      }


      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );

      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } catch (e) {
      throw ServerException(e.toString());
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
