import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class RestaurantsRepository{
  Future<Either<Failure,List<RestaurantEntity>>> getRestaurantsList(int offset);
}