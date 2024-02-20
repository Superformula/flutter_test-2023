import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';

import '../../../main.dart';

abstract interface class RestaurantsLocalDataSource {
  Future<void> saveRestaurants(RestaurantQueryResult restaurantQueryResult);

  Future<Restaurant> getRestaurantDetails(String id);
}

/// Calls the SharedPreferences Local Data Source
///
/// Throws a [CacheException] in case of Exception.
///
class SharedPreferencesRestaurantsLocalDataSource implements RestaurantsLocalDataSource {
  final LocalStorage localStorage;
  static const restaurantsCacheKey = 'restaurant_details';

  SharedPreferencesRestaurantsLocalDataSource(this.localStorage);

  @override
  Future<Restaurant> getRestaurantDetails(String id) async {
    try {
      final result = await localStorage.fetchData(restaurantsCacheKey);
      final Map<String, dynamic> jsonData = json.decode(result);
      final queryResult = RestaurantQueryResult.fromJson(jsonData);

      if (queryResult.restaurants == null) {
        throw EmptyDataException('No restaurant data saved.');
      }

      Restaurant? restaurant = queryResult.restaurants!.firstWhere(
        (element) => element.id == id,
        orElse: () {
          throw EmptyDataException('No restaurant data saved for this restaurant id ($id).');
        },
      );

      return restaurant;
    } catch (_) {
      rethrow;
      //CacheException, EmptyDataException or generic
    }
  }

  @override
  Future<void> saveRestaurants(RestaurantQueryResult restaurantQueryResult) async {
    localStorage.saveData(restaurantsCacheKey, json.encode(restaurantQueryResult.toJson()));
  }
}
