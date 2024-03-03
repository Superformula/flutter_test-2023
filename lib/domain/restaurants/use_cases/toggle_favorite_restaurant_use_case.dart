import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';

class ToggleFavoriteRestaurantUseCase {
  final SharedPreferencesRepository _preferencesRepository;

  ToggleFavoriteRestaurantUseCase(this._preferencesRepository);

  Future<void> call(String restaurantId) async {
    await _preferencesRepository.toggleFavoriteRestaurant(restaurantId);
  }
}
