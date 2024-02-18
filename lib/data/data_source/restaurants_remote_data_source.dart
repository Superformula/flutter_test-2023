import 'package:dio/dio.dart';
import 'package:restaurantour/core/constants.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants({int offset = 0});
}

class RestaurantRemoteDataSourceImpl extends RestaurantsRemoteDataSource {
  final Dio dio;
  RestaurantRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RestaurantModel>> getRestaurants({int offset = 0}) async {
    dio.options = BaseOptions(
      baseUrl: Urls.baseUrl,
      headers: {
        'Authorization': Urls.bearerToken,
        'Content-Type': 'application/graphql',
      },
    );

    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: Urls.getQuery(offset),
    );
    if (response.statusCode == 200) {
      return response.data!['data']['search']['business']
          .map((data) => RestaurantModel.fromJson(data))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
