import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class DeleteFavoriteRestaurantUseCase {
  DeleteFavoriteRestaurantUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<void> call({required String? id}) {
    return _restaurantRepository.deleteFavoriteRestaurant(id: id);
  }
}
