import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class AddFavoriteRestaurantUseCase {
  AddFavoriteRestaurantUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<void> call({
    required RestaurantEntity restaurant,
  }) {
    return _restaurantRepository.addFavoriteRestaurant(restaurant: restaurant);
  }
}
