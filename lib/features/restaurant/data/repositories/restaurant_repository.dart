import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:restaurantour/features/restaurant/data/models/restaurant_query_result_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class RestaurantRepository implements IRestaurantRepository {
  RestaurantRepository({
    required RestaurantRemoteDatasource restaurantRemoteDatasource,
  }) : _restaurantRemoteDatasource = restaurantRemoteDatasource;

  final RestaurantRemoteDatasource _restaurantRemoteDatasource;

  @override
  Future<Either<String, List<RestaurantEntity>>>
      getAllRestaurants() async {
    try {
      final response = await _restaurantRemoteDatasource.fetchAllRestaurants();

      return Right(
        RestaurantQueryResultModel.fromJson(
          response.data!['data']['search'],
        ).restaurants ?? [],
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
