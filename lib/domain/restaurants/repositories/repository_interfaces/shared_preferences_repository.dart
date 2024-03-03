abstract class SharedPreferencesRepository {
  Future<void> toggleFavoriteRestaurant(String restaurantId);
  Future<List<String>> getFavoriteRestaurants();
  Stream<List<String>> watchFavoriteRestaurants();
}
