import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_query_result_entity.dart';

abstract class IRestaurantRepository {
  Future<Either<String, List<RestaurantEntity>>>
  getAllRestaurants();
}
