import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:restaurantour/repositories/yelp_repository.dart';

import '../models/restaurant.dart';
import '../utils/queries.dart';

const apiKey =
    '61mpkUaz3FTiG02NPwtFuvw69IBUrQeWMGzcxa6OrDPb_WNYnMHCJvTJRCIWA3T-Kxmahy_nkCR9jRkv-QFaatXGBOdTkiGvLIJn-cw8tclL0zYYcCzzbNQPfy_NZXYx';

class YelpService implements YelpRepository {
  late Dio dio;

  YelpService({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer $apiKey',
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

      final cleanResponse = response.data ?? <String, dynamic>{};

      if (cleanResponse.isNotEmpty) {
        return RestaurantQueryResult.fromJson(cleanResponse['data']['search']);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

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


