import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';

abstract class IRestaurantRepository {
  Future<Either<String, List<RestaurantEntity>>> getAllRestaurants();
  Future<List<RestaurantEntity>> getFavoriteRestaurants();
  Future<void> addFavoriteRestaurant({
    required RestaurantEntity restaurant,
  });
  Future<void> deleteFavoriteRestaurant({required String? id});
}
