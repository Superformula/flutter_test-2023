import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:restaurantour/data/constants.dart';
import 'package:restaurantour/data/models/restaurant.dart';

abstract class RemoteDataSource {
  Future<RestaurantQueryResult?> getRestaurants();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl()
      : dio = Dio(
          BaseOptions(
            baseUrl: Urls.baseUrl,
            headers: {
              'Authorization': 'Bearer ${Urls.apiKey}',
              'Content-Type': 'application/graphql',
            },
          ),
        );

  late Dio dio;

  @override
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        Urls.ghrapQLRoute,
        data: Urls.getRestaurantsByCity(
          city: "Las Vegas",
          limit: 20,
          offset: offset,
        ),
      );
      final String json = jsonEncode(response.data);
      Logger().i(json);
      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
