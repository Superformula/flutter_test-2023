import 'package:restaurantour/domain/restaurants/repository_interfaces/preferences_repository.dart';

class SaveFavoriteRestaurantUseCase {
  final PreferencesRepository _preferencesRepository;

  SaveFavoriteRestaurantUseCase(this._preferencesRepository);

  Future<void> call(String restaurantId) async {
    await _preferencesRepository.addFavoriteRestaurant(restaurantId);
    final currentFavorites =
        await _preferencesRepository.getFavoriteRestaurants();
    print('Current favorites: $currentFavorites');
  }
}
