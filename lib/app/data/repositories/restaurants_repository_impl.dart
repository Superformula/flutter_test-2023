import 'package:flutter/foundation.dart';
import 'package:restaurantour/app/core/error/error_messages.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/core/error/failures.dart';
import 'package:restaurantour/app/data/services/network_info_service.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';
import 'package:restaurantour/app/interactor/repositories/restaurants_repository.dart';

import '../data_sources/resturants_local_data_source.dart';
import '../data_sources/resturants_remote_data_source.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  final RestaurantsRemoteDataSource remoteDataSource;
  final RestaurantsLocalDataSource localDataSource;
  final NetworkInfoService networkInfo;

  const RestaurantsRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<(List<Restaurant>?, RestaurantListFailure?)> getRestaurants({int offset = 0}) async {
    final bool isConnected = await networkInfo.isConnected();

    if (!isConnected) {
      return (null, const RestaurantListFailure(ErrorMessages.noInternetConnection));
    }
    try {
      final result = await remoteDataSource.getRestaurants(offset: offset);
      localDataSource.saveRestaurants(result);

      return (result.restaurants, null);
    } on ServerException {
      return (null, const RestaurantListFailure(ErrorMessages.serverException));
    }
  }

  @override
  Future<(Restaurant?, RestaurantDetailsFailure?)> getRestaurantDetails(String id) async {
    try {
      final result = await localDataSource.getRestaurantDetails(id);
      return (result, null);
    } on EmptyDataException catch (e) {
      return (null, RestaurantDetailsFailure(e.message));
    } on CacheException {
      return (null, const RestaurantDetailsFailure(ErrorMessages.cacheException));
    } catch (e, s) {
      debugPrint('getRestaurantDetails unknown Exception: $e, $s');
      return (null, const RestaurantDetailsFailure(ErrorMessages.unknownException));
    }
  }

  @override
  Future<(List<Restaurant>?, FavoriteRestaurantsFailure?)> getFavoriteRestaurants() async {
    try {
      final result = await localDataSource.getFavoriteRestaurants();
      return (result, null);
    } on EmptyDataException catch (e) {
      return (null, FavoriteRestaurantsFailure(e.message));
    } on CacheException {
      return (null, const FavoriteRestaurantsFailure(ErrorMessages.cacheException));
    } catch (e, s) {
      debugPrint('getFavoriteRestaurants unknown Exception: $e, $s');
      return (null, const FavoriteRestaurantsFailure(ErrorMessages.unknownException));
    }
  }

  @override
  Future<(void, FavoriteRestaurantsFailure?)> addFavoriteRestaurant(String id) {
    // TODO: implement addFavoriteRestaurant
    throw UnimplementedError();
  }

  @override
  Future<bool> checkIfItIsFavoriteRestaurant(String id) {
    // TODO: implement checkIfItIsFavoriteRestaurant
    throw UnimplementedError();
  }
}
