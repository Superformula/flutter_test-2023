import 'dart:async';

import 'package:restaurantour/domain/restaurants/repository_interfaces/preferences_repository.dart';

class WatchFavoriteRestaurantsUseCase {
  final PreferencesRepository _preferencesRepository;

  WatchFavoriteRestaurantsUseCase(this._preferencesRepository);

  Stream<List<String>> call() {
    return _preferencesRepository.watchFavoriteRestaurants();
  }
}
