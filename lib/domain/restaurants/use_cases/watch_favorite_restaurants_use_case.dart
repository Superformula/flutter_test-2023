import 'dart:async';

import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';

class WatchFavoriteRestaurantsUseCase {
  final SharedPreferencesRepository _preferencesRepository;

  WatchFavoriteRestaurantsUseCase(this._preferencesRepository);

  Stream<List<String>> call() {
    return _preferencesRepository.watchFavoriteRestaurants();
  }
}
