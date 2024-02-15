import 'package:dio/dio.dart';
import 'package:restaurantour/core/network/custom_dio/custom_dio_creator.dart';

class RestaurantRemoteDatasource {
  final dio = CustomDioCreator();

  Future<Response<Map<String, dynamic>>> fetchAllRestaurants(
      {int offset = 0}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: _getQuery(offset),
    );

    return response;
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
