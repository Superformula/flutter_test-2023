import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/data/exceptions/network_exception.dart';
import 'package:restaurantour/data/models/restaurant.dart';

const _apiKey =
    'wfYIpeyetAPJbQYg5ITUE4wxzqCvoEQM5FQyW9Xq4SGJG52vkefWY_Irq9yg_TKpXRYJUgTO48W_fVXReEABY919sT74bHoCAyNH4b0kTe94rmEWFWNo1GjFxUXjZXYx';

class YelpSource {
  late Dio dio;

  YelpSource({
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

  /// Returns a response in this shape
  /// {
  /// "data": {
  ///   "search": {
  ///     "total": 5056,
  ///     "business": [
  ///       {
  ///         "id": "faPVqws-x-5k2CQKDNtHxw",
  ///         "name": "Yardbird Southern Table & Bar",
  ///         "price": "2",
  ///         "rating": 4.5,
  ///         "photos": [
  ///           "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
  ///         ],
  ///         "reviews": [
  ///           {
  ///             "id": "sjZoO8wcK1NeGJFDk5i82Q",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "BuBCkWFNT_O2dbSnBZvpoQ",
  ///               "image_url": "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
  ///               "name": "Gina T."
  ///             }
  ///           },
  ///           {
  ///             "id": "okpO9hfpxQXssbTZTKq9hA",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "0x9xu_b0Ct_6hG6jaxpztw",
  ///               "image_url": "https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg",
  ///               "name": "Crystal L."
  ///             }
  ///           },
  ///        ...
  ///     ]
  ///   }
  /// }
  ///

  Future<List<Restaurant>?> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage,
        );
      } else if (response.statusCode != null) {
        return RestaurantQueryResult.fromJson(response.data!['data']['search'])
            .restaurants;
      }
    } catch (e) {
      throw Exception('Failed to get restaurants: $e');
    }
    return null;
  }

  String _getQuery(int offset) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: 1, offset: $offset) {
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
        text
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
