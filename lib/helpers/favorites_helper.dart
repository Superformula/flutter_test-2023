import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesHelpers extends ChangeNotifier {
  late SharedPreferences? prefs = null;
  List<String> favorites = [];
  String prefsKey = "favorites";

  Future<String?> addFavorite(String id) async {
    try {
      prefs ??= await SharedPreferences.getInstance();
      await getFavorites();
      if (!favorites.any((element) => element == id)) {
        favorites.add(id);
      }
      await prefs!.setStringList(prefsKey, favorites);
      print("id $id added to favorites!");
      await getFavorites();
      return null;
    } catch (error) {
      print("Error adding to favorite: $error");
      return error.toString();
    }
  }

  Future<String?> removeFavorite(String id) async {
    try {
      prefs ??= await SharedPreferences.getInstance();
      await getFavorites();
      if (!favorites.any((element) => element == id)) {
        favorites.removeWhere(
          (element) => element == id,
        );
      }
      await prefs!.setStringList(prefsKey, favorites);
      print("id $id added to favorites!");
      await getFavorites();
      return null;
    } catch (error) {
      print("Error adding to favorite: $error");
      return error.toString();
    }
  }

  Future<String?> getFavorites() async {
    try {
      prefs ??= await SharedPreferences.getInstance();
      favorites = await prefs!.getStringList(prefsKey) ?? [];
      print("Favorites: $favorites");
      notifyListeners();
      return null;
    } catch (error) {
      return error.toString();
    }
  }
}
