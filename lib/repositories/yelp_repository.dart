import 'package:dio/dio.dart';
import 'package:restaurantour/models/restaurant.dart';

class YelpRepository {
  final Dio dio;

  YelpRepository({required this.dio});

  /// Returns a response in this shape
  /// {
  /// "data": {
  ///   "search": {
  ///     "total": 5056,
  ///     "business": [
  ///       {
  ///         "id": "faPVqws-x-5k2CQKDNtHxw",
  ///         "name": "Yardbird Southern Table & Bar",
  ///         "price": "$$",
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
