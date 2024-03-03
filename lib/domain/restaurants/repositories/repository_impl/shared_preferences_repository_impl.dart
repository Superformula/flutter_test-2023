import 'package:restaurantour/data/sources/shared_preferences_source.dart';
import 'package:restaurantour/domain/restaurants/repositories/repository_interfaces/shared_preferences_repository.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  final SharedPreferencesSource _sharedPreferencesRepository;
  SharedPreferencesRepositoryImpl(this._sharedPreferencesRepository);

  @override
  Future<void> toggleFavoriteRestaurant(String restaurantId) {
    return _sharedPreferencesRepository.toggleFavoriteRestaurant(restaurantId);
  }

  @override
  Future<List<String>> getFavoriteRestaurants() {
    return _sharedPreferencesRepository.getFavoriteRestaurants();
  }

  @override
  Stream<List<String>> watchFavoriteRestaurants() {
    return _sharedPreferencesRepository.watchFavoriteRestaurants();
  }
}
