import 'package:restaurantour/features/restaurant/domain/repositories/irestaurant_repository.dart';

class SetFavoriteRestaurantsIdsUseCase {
  SetFavoriteRestaurantsIdsUseCase({
    required IRestaurantRepository restaurantRepository,
  }) : _restaurantRepository = restaurantRepository;

  final IRestaurantRepository _restaurantRepository;

  Future<void> call({
    required List<String> favoriteRestaurantIdsList,
  }) {
    return _restaurantRepository.setFavoriteRestaurantsIds(
      favoriteRestaurantsIdsList: favoriteRestaurantIdsList,
    );
  }
}
