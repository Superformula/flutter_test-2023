import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class GetFavoriteRestaurantsIdsUseCase {
  GetFavoriteRestaurantsIdsUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<List<String>> call() {
    return _restaurantRepository.getFavoriteRestaurantsIds();
  }
}
