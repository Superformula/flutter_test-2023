import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';

class GetRestaurantFavoriteStatusUseCase {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  GetRestaurantFavoriteStatusUseCase(this._sharedPreferencesRepository);

  Future<bool> call(String restaurantId) async {
    final List<String> favoriteRestaurants =
        await _sharedPreferencesRepository.getFavoriteRestaurants();
    return favoriteRestaurants.contains(restaurantId);
  }
}
