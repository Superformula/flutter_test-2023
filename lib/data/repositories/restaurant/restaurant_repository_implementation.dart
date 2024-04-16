import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/data/datasources/datasources.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/repositories/repositories.dart';

@LazySingleton(as: RestaurantRepository)
class RestaurantRepositoryImplementation extends RestaurantRepository {
  final RestaurantDatasource _restaurantDatasource;

  RestaurantRepositoryImplementation({
    required RestaurantDatasource restaurantDatasource,
  }) : _restaurantDatasource = restaurantDatasource;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList() async {
    try {
      final result = await _restaurantDatasource.getRestaurantsList();

      return Right(result);
    } catch (e) {
      return Left(RestaurantListFailure(message: e.toString()));
    }
  }
}
