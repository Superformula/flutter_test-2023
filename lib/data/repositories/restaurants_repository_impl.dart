import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';

class RestaurantsRepositoryImpl extends RestaurantsRepository{
  final RestaurantsRemoteDataSource restaurantsRemoteDataSource;
  RestaurantsRepositoryImpl({required this.restaurantsRemoteDataSource});
  
  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList({int offset=0}) async{

    try {
      final result = await restaurantsRemoteDataSource.getRestaurants(offset: offset);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
        return const Left(ServerFailure('An error occurred'));
    } on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}