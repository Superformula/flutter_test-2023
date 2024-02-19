import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';
import 'package:restaurantour/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl extends ReviewsRepository{
  final RestaurantsRemoteDataSource restaurantsRemoteDataSource;
  ReviewRepositoryImpl({required this.restaurantsRemoteDataSource});
  
  @override
  Future<Either<Failure,List<ReviewEntity>>> getReviewsList({required String id}) async{

    try {
      final result = await restaurantsRemoteDataSource.getReviewsList(id: id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
        return const Left(ServerFailure('An error occurred'));
    } on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}