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
    } catch (e) {
      return (null, const RestaurantDetailsFailure(ErrorMessages.unknownException));
    }
  }

  @override
  Future<(List<Restaurant>?, FavoriteRestaurantsFailure?)> getFavoriteRestaurants() {
    // TODO: implement getFavoriteRestaurants
    throw UnimplementedError();
  }

  @override
  Future<(void, FavoriteRestaurantsFailure?)> addFavoriteRestaurant(Restaurant restaurant) {
    // TODO: implement addFavoriteRestaurant
    throw UnimplementedError();
  }
}
