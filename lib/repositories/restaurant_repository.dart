import 'package:dio/dio.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantRepository {
  final Dio dio;

  RestaurantRepository({required this.dio});

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: _getQuery(offset),
    );
    return RestaurantQueryResult.fromJson(response.data!['data']['search']);
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
