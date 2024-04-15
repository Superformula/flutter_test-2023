abstract class FavoriteRepository {
  Future<void> addFavorite(String id);
  Future<void> removeFavorite(String id);
  Future<List<String>> getFavorites();
}
