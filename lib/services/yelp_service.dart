import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../repositories/yelp_repository.dart';
import '../utils/constants.dart';
import '../utils/queries.dart';

class YelpService implements YelpRepository {
  late Dio dio;

  YelpService({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer ${AppConstants.apiKey}',
                  'Content-Type': 'application/graphql',
                },
              ),
            );

  @override
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: AppQueries.getQuery(offset),
      );

      final int statusCode = response.statusCode ?? 500;

      final cleanResponse = response.data ?? <String, dynamic>{};

      if (statusCode == 200) {
        return RestaurantQueryResult.fromJson(
          cleanResponse['data']['search'],
        );
      } else {
        throw Exception("Error while fetching data");
      }
    } catch (e) {
      return null;
    }
  }
}
