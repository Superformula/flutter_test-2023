import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';

class SaveFavoriteRestaurantUseCase {
  final SharedPreferencesRepository _preferencesRepository;

  SaveFavoriteRestaurantUseCase(this._preferencesRepository);

  Future<void> call(String restaurantId) async {
    await _preferencesRepository.addFavoriteRestaurant(restaurantId);
    final currentFavorites =
        await _preferencesRepository.getFavoriteRestaurants();
    print('Current favorites: $currentFavorites');
  }
}
