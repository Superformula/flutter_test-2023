import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:yelp_repository/src/models/review.dart';
import 'package:yelp_repository/src/web/client.dart';
import 'package:yelp_repository/src/models/restaurant_query_result.dart';
import 'package:domain_models/domain_models.dart' as domain;

// TODO: Refactor to use flutter_dotenv, this way enabled the team to insert the keys using the pipeline
const _apiKey = String.fromEnvironment('yelpApiKey');

class YelpRepository {
  final _baseUrl = 'https://api.yelp.com';
  final _endPoint = 'v3/graphql';
  final header = {
    'Authorization': 'Bearer $_apiKey',
    'Content-Type': 'application/graphql',
  };
  late final Client _client;

  YelpRepository({@visibleForTesting Client? client})
      : _client = client ?? webClient;

  Uri get _uri => Uri.parse('$_baseUrl/$_endPoint');

  Future<List<domain.Restaurant>> getRestaurants({int offset = 0}) async {
    final response = await _client.post(
      _uri,
      headers: header,
      body: _getRestaurantsQuery(offset),
    );

    if (response.statusCode != 200) {
      throw domain.NetworkException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
    final restaurantQueryResult = RestaurantQueryResult.fromJson(
      json.decode(utf8.decode(response.bodyBytes))['data']['search'],
    );
    return restaurantQueryResult.domainRestaurants;
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

  Future<List<domain.Review>> getReviews({
    required String restaurantId,
    int offset = 0,
  }) async {
    final response = await _client.post(
      _uri,
      headers: header,
      body: _getReviewsQuery(restaurantId, offset),
    );

    if (response.statusCode != 200) {
      throw domain.NetworkException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }

    final jsonList = json.decode(utf8.decode(response.bodyBytes))['data']
        ['business']['reviews'] as List<dynamic>;
    return jsonList.map((json) => Review.fromJson(json).toDomain).toList();
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
