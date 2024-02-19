import 'package:dartz/dartz.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';

abstract class RestaurantDetailsRepository{
  Future<Either<Failure,RestaurantDetailsEntity>> getRestaurantDetails({required String id});
}