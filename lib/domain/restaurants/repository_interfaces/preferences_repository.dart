abstract class PreferencesRepository {
  Future<void> addFavoriteRestaurant(String restaurantId);
  Future<List<String>> getFavoriteRestaurants();
  Stream<List<String>> watchFavoriteRestaurants();
}
