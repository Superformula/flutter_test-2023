import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class GetFavoriteRestaurantsUseCase {
  GetFavoriteRestaurantsUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<List<RestaurantEntity>> call() {
    return _restaurantRepository.getFavoriteRestaurants();
  }
}
