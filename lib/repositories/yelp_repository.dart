import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/repositories/endpoints.dart';

class YelpRepository {
  late Dio dio;

  YelpRepository({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                headers: {
                  'Authorization': 'Bearer $yelpKey',
                  'Content-Type': 'application/graphql'
                },
              ),
            );

  Future<Response> getResponse({
    required String path,
    required String query,
  }) async {
    try {
      return await dio.post<Map<String, dynamic>>(
        path,
        data: query,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
