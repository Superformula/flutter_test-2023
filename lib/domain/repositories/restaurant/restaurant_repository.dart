import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/domain/entities/entities.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurantsList();
}
