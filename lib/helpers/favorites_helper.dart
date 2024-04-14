import 'package:shared_preferences/shared_preferences.dart';

class FavoritesHelpers {
  late final SharedPreferences? prefs;

  Future<String?> addFavorite(String id) async {
    try {
      prefs ??= await SharedPreferences.getInstance();
      var favorites = await getFavorites();
      if (!favorites.any((element) => element == id)) {
        favorites.add(id);
      }
      await prefs!.setStringList('favorites', favorites);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  Future<List<String>> getFavorites() async {
    try {
      prefs ??= await SharedPreferences.getInstance();
      return await prefs!.getStringList('favorites') ?? [];
    } catch (error) {
      return [];
    }
  }
}
