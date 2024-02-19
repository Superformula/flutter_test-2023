import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/core/error/failures.dart';
import 'package:restaurantour/app/data/services/network_info_service.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';
import 'package:restaurantour/app/interactor/repositories/restaurants_repository.dart';

import '../data_sources/resturants_remote_data_source.dart';

class YelpRestaurantsRepositoryImpl implements RestaurantsRepository {
  final RestaurantsRemoteDataSource remoteDataSource;
  final NetworkInfoService networkInfo;

  const YelpRestaurantsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<(List<Restaurant>?, RestaurantListFailure?)> getRestaurants({int offset = 0}) async {
    final bool isConnected = await networkInfo.isConnected();

    if (!isConnected) {
      return (null, const RestaurantListFailure('Unable to establish an internet connection'));
    }
    try {
      final result = await remoteDataSource.getRestaurants(offset: offset);

      return (result.restaurants, null);
    } on ServerException {
      return (null, const RestaurantListFailure('Oops! We had an internal problem. Try again!'));
    }
  }

  @override
  Future<(List<Restaurant>?, FavoriteRestaurantsFailure?)> getFavoriteRestaurants() {
    // TODO: implement getFavoriteRestaurants
    throw UnimplementedError();
  }

  @override
  Future<(Restaurant?, RestaurantDetailsFailure?)> getRestaurantDetails(String id) {
    // TODO: implement getRestaurantDetails
    throw UnimplementedError();
  }
}
