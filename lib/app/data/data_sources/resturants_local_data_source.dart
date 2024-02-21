import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:restaurantour/app/core/error/error_messages.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';

import '../../../main.dart';

abstract interface class RestaurantsLocalDataSource {
  Future<void> saveRestaurants(RestaurantQueryResult restaurantQueryResult);

  Future<Restaurant> getRestaurantDetails(String id);

  Future<void> addFavoriteRestaurant(String id);

  Future<List<Restaurant>> getFavoriteRestaurants();

  Future<bool> checkIfItIsFavoriteRestaurant(String id);
}

/// Calls the SharedPreferences Local Data Source
///
/// Throws a [CacheException] in case of Exception.
///
class RestaurantsLocalDataSourceImpl implements RestaurantsLocalDataSource {
  final LocalStorage localStorage;
  static const restaurantsCacheKey = 'restaurant_details';
  static const favoriteRestaurantsCacheKey = 'favorite_restaurants';

  RestaurantsLocalDataSourceImpl(this.localStorage);

  @override
  Future<Restaurant> getRestaurantDetails(String id) async {
    try {
      final result = await localStorage.fetchData(restaurantsCacheKey);
      final Map<String, dynamic> jsonData = json.decode(result);
      final queryResult = RestaurantQueryResult.fromJson(jsonData);

      if (queryResult.restaurants == null || queryResult.restaurants!.isEmpty) {
        throw EmptyDataException(ErrorMessages.noRestaurantData);
      }

      Restaurant? restaurant = queryResult.restaurants!.firstWhere(
        (element) => element.id == id,
        orElse: () {
          throw EmptyDataException(ErrorMessages.noDataForRestaurantId(id));
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

  @override
  Future<void> addFavoriteRestaurant(String id) async {
    try {
      var result = await localStorage.fetchListData(favoriteRestaurantsCacheKey);
      result.add(id);
      localStorage.saveList(favoriteRestaurantsCacheKey, result);
      return;
    } on CacheException {
      throw CacheException(ErrorMessages.cacheException);
    }
  }

  @override
  Future<List<Restaurant>> getFavoriteRestaurants() async {
    try {
      final allRestaurants = await localStorage.fetchData(restaurantsCacheKey);

      final Map<String, dynamic> jsonData = json.decode(allRestaurants);
      final queryResult = RestaurantQueryResult.fromJson(jsonData);

      if (queryResult.restaurants == null || queryResult.restaurants!.isEmpty) {
        throw EmptyDataException(ErrorMessages.noRestaurantData);
      }

      final List<String> favoriteRestaurantsIds =
          await localStorage.fetchListData(favoriteRestaurantsCacheKey);

      final favoriteRestaurants = queryResult.restaurants!
          .where((restaurant) => favoriteRestaurantsIds.contains(restaurant.id))
          .toList();

      return favoriteRestaurants;
    } catch (_) {
      rethrow;
      //CacheException, EmptyDataException or generic
    }
  }

  @override
  Future<bool> checkIfItIsFavoriteRestaurant(String id) async {
    try {
      final result = await localStorage.fetchListData(favoriteRestaurantsCacheKey);

      return result.contains(id);
    } on CacheException {
      throw CacheException(ErrorMessages.cacheException);
    }
  }
}
