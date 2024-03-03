abstract class SharedPreferencesRepository {
  Future<void> addFavoriteRestaurant(String restaurantId);
  Future<List<String>> getFavoriteRestaurants();
  Stream<List<String>> watchFavoriteRestaurants();
}
