import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';

abstract class IRestaurantRepository {
  Future<Either<String, List<RestaurantEntity>>> getAllRestaurants();
  Future<List<String>> getFavoriteRestaurantsIds();
  Future<void> setFavoriteRestaurantsIds({
    required List<String> favoriteRestaurantsIdsList,
  });
}
