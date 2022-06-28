import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/data/failures/failures.dart';
import 'package:restaurantour/data/models/models.dart';

@LazySingleton()
class YelpRepository {
  final Dio _dio;

  YelpRepository(this._dio);

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
  Future<Either<RestaurantFailure, RestaurantQueryResult>> getRestaurants({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset: offset, limit: limit),
      );

      return right(
        RestaurantQueryResult.fromJson(response.data!['data']['search']),
      );
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          return left(const RestaurantFailure.unauthorized());
        case 500:
          return left(const RestaurantFailure.serverError());
        default:
          return left(const RestaurantFailure.unexpected());
      }
    } catch (e) {
      return left(const RestaurantFailure.unexpected());
    }
  }

  String _getQuery({required int offset, required int limit}) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: $limit, offset: $offset) {
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
