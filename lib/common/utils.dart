import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:restaurantour/models/restaurant.dart';

class Utils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favorites.json');
  }

  static Future<List<Restaurant>> loadFavorites() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        return jsonData.map((item) => Restaurant.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      // Handle the exception, possibly logging or showing a message to the user
      return [];
    }
  }

  static Future<void> addFavorite(Restaurant restaurant) async {
    final favorites = await loadFavorites();
    if (!favorites.any((element) => element.id == restaurant.id)) {
      favorites.add(restaurant);
      await _saveToFile(favorites);
    }
  }

  static Future<void> removeFavorite(String id) async {
    final favorites = await loadFavorites();
    favorites.removeWhere((restaurant) => restaurant.id == id);
    await _saveToFile(favorites);
  }

  static Future<void> _saveToFile(List<Restaurant> restaurants) async {
    final file = await _localFile;
    final String jsonString =
        json.encode(restaurants.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<void> toggleFavorite(Restaurant restaurant) async {
    final favorites = await loadFavorites();
    final existingIndex = favorites.indexWhere((r) => r.id == restaurant.id);

    if (existingIndex >= 0) {
      // Restaurant is already a favorite, remove it
      await removeFavorite(restaurant.id!);
    } else {
      // Restaurant is not a favorite, add it
      await addFavorite(restaurant);
    }
  }
}
