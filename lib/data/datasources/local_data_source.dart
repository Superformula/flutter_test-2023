import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String id);
  Future<void> removeFavorite(String id);
}

const key = 'favorites';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> addFavorite(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (favorites.contains(id)) return;
    favorites.add(id);
    sharedPreferences.setStringList(key, favorites);
  }

  @override
  Future<List<String>> getFavorites() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final favorites = sharedPreferences.getStringList(key);
    return favorites ?? [];
  }

  @override
  Future<void> removeFavorite(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(id);
    sharedPreferences.setStringList(key, favorites);
  }
}
