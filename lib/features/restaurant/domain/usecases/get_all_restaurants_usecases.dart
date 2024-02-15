import 'package:dartz/dartz.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class GetAllRestaurantsUseCase {
  GetAllRestaurantsUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<Either<String, List<RestaurantEntity>>> call() {
    return _restaurantRepository.getAllRestaurants();
  }
}
