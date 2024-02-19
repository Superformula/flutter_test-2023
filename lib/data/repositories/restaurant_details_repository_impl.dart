import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';
import 'package:restaurantour/domain/repositories/restaurant_details_repository.dart';

class RestaurantDetailsRepositoryImpl extends RestaurantDetailsRepository{
  final RestaurantsRemoteDataSource restaurantsRemoteDataSource;
  RestaurantDetailsRepositoryImpl({required this.restaurantsRemoteDataSource});
  
  @override
  Future<Either<Failure, RestaurantDetailsEntity>> getRestaurantDetails({required String id}) async{

    try {
      final result = await restaurantsRemoteDataSource.getRestaurantDetails(id: id);
      return Right(result.toEntity());
    } on ServerException {
        return const Left(ServerFailure('An error occurred'));
    } on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}