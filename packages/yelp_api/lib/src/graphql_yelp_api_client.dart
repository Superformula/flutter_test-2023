import 'package:dio/dio.dart';
import 'package:yelp_api/yelp_api.dart';

class GraphQlYelpApiClient extends YelpApi {
  GraphQlYelpApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
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
