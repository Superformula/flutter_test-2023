import 'package:dio/dio.dart';
import 'package:yelp_api/yelp_api.dart';

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown is an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// {@template graphql_yelp_api_client}
/// A Dart API Client for the GraphQL Yelp API.
/// {@endtemplate}

class GraphQlYelpApiClient extends YelpApi {
  GraphQlYelpApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    Response response;
    try {
      response = await _dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode != null) {
        throw HttpRequestFailure(e.response!.statusCode!);
      } else {
        throw HttpException();
      }
    }

    try {
      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } on Exception {
      throw JsonDeserializationException();
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
