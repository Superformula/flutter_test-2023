import 'package:dio/dio.dart';
import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/utils/utils.dart';

class YelpService {
  final Dio dio;

  const YelpService({required this.dio});

  Future<RestaurantQueryResult> getRestaurants({int offset = 0}) async {
    final response = await dio.post(
      AppConstants.baseUrl,
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
