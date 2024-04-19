import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:restaurant_repository/src/models/restaurant_query_result.dart';
import 'package:restaurant_repository/src/web/client.dart';

const _apiKey = String.fromEnvironment('yelpApiKey');

class YelpRepository {
  final _baseUrl = 'https://api.yelp.com';
  final _endPoint = 'v3/graphql';
  final header = {
    'Authorization': 'Bearer $_apiKey',
    'Content-Type': 'application/graphql',
  };
  late final Client _client;
  Uri get _uri => Uri.parse('$_baseUrl/$_endPoint');

  YelpRepository({@visibleForTesting Client? client})
      : _client = client ?? webClient;

  /// Returns a response in this shape
  /// ```json
  /// {
  ///   "data": {
  ///     "search": {
  ///       "total": 5056,
  ///       "business": [
  ///         {
  ///           "id": "faPVqws-x-5k2CQKDNtHxw",
  ///           "name": "Yardbird Southern Table & Bar",
  ///           "price": "$$",
  ///           "rating": 4.5,
  ///           "photos": [
  ///             "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
  ///           ],
  ///           "reviews": [
  ///             {
  ///               "id": "sjZoO8wcK1NeGJFDk5i82Q",
  ///               "rating": 5,
  ///               "user": {
  ///                 "id": "BuBCkWFNT_O2dbSnBZvpoQ",
  ///                 "image_url": "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
  ///                 "name": "Gina T."
  ///               }
  ///             },
  ///             {
  ///               "id": "okpO9hfpxQXssbTZTKq9hA",
  ///               "rating": 5,
  ///               "user": {
  ///                 "id": "0x9xu_b0Ct_6hG6jaxpztw",
  ///                 "image_url": "https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg",
  ///                 "name": "Crystal L."
  ///               }
  ///             },
  ///          ...
  ///       ]
  ///     }
  /// }
  /// ``` 
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    final response = await _client.post(
      _uri,
      headers: header,
      body: _getRestaurantsQuery(offset),
    );

    if (response.statusCode != 200) {
      // TODO: Create exceptions on domain package to be thrown here
      throw Exception();
    }
    return RestaurantQueryResult.fromJson(
      json.decode(utf8.decode(response.bodyBytes))['data']['search'],
    );
  }

  String _getRestaurantsQuery(int offset) {
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

  /// Returns a response in this shape
  ///
  /// ```json
  /// {
  ///   "data": {
  ///     "business": {
  ///       "reviews": [
  ///         {
  ///           "id": "F8tEzjNcVF778CANn9tkLA",
  ///           "rating": 5,
  ///           "text": "Why in the world did I wait so long to visit Bavette's!? Don't make the same mistake as me and book your romantic date night here ASAP. \n\nIt may not look...",
  ///           "time_created": "2024-04-10 15:55:00",
  ///           "user": {
  ///             "id": "zK4R5IFl5aBqePPEd0fvxw",
  ///             "image_url": "https://s3-media3.fl.yelpcdn.com/photo/rBt0S0z6NESBswiuaELa8w/o.jpg",
  ///             "name": "McKenzie S."
  ///           }
  ///         }
  ///       ]
  ///     }
  ///   }
  /// }
  /// ```
  Future<void> getReviews({
    required String restaurantId,
    int offset = 0,
  }) async {
    final response = await _client.post(
      _uri,
      headers: header,
      body: _getReviewsQuery(restaurantId, offset),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    // TODO: Create a domain model for reviews
  }

  String _getReviewsQuery(String businessId, int offset) {
    return '''
query getReviews {
  business(id: "$businessId") {
    reviews(limit: 20, offset: $offset) {
      id
      rating
      text
      time_created
      user {
        id
        image_url
        name
      }
    }
  }
}
''';
  }
}
