import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  final SharedPreferences sharedPreferences;
  final String favoritesKey = 'favorites';

  FavoriteService({required this.sharedPreferences});

  Future<List<String>> loadFavorites() async {
    List<String>? favoriteItems = sharedPreferences.getStringList(favoritesKey);
    favoriteItems ??= [];
    return favoriteItems;
  }

  Future<void> addFavorite(String restaurantId) async {
    List<String>? favoriteItems = sharedPreferences.getStringList(favoritesKey);
    favoriteItems ??= [];
    favoriteItems.add(restaurantId);
    await sharedPreferences.setStringList(favoritesKey, favoriteItems);
  }

  Future<void> removeFavorite(String restaurantId) async {
    List<String>? favoriteItems = sharedPreferences.getStringList(favoritesKey);
    favoriteItems ??= [];
    favoriteItems.remove(restaurantId);
    await sharedPreferences.setStringList(favoritesKey, favoriteItems);
  }
}
