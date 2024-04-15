import 'dart:io';

import 'package:restaurantour/data/datasources/remote_data_source.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  final RemoteDataSource remoteDataSource;

  RestaurantsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RestaurantQueryResult?> getRestaurants() async {
    try {
      return await remoteDataSource.getRestaurants();
    } on SocketException {
      throw Exception('No internet connection');
    }
  }
}
