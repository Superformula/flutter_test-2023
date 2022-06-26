import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/key_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalDB {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static final LocalDB instance = LocalDB._internal();

  LocalDB._internal();

  saveRestaurants(List<Restaurant> restaurants) async =>
      (await _prefs).setString(DBKey.restaurantList, json.encode(restaurants));

  readRestaurants() async =>
      json.decode((await _prefs).getString(DBKey.restaurantList) ?? "None");

  updateFavorite(String id, bool newFavorite) async {
    SharedPreferences prefs = await _prefs;
    List<String>? favoriteList = prefs.getStringList(DBKey.favoriteList);

    if (favoriteList == null) {
      favoriteList = [];
      if (newFavorite) {
        favoriteList.add(id);
      }
    } else {
      if (newFavorite) {
        favoriteList.add(id);
      } else {
        favoriteList.removeWhere((element) => element == id);
      }
    }
    prefs.setStringList(DBKey.favoriteList, favoriteList);
  }

  get favoriteList async => (await _prefs).getStringList(DBKey.favoriteList);

  isFavorite(String id) async {
    List<String>? favoriteList =
        (await _prefs).getStringList(DBKey.favoriteList);
    return favoriteList?.contains(id) ?? false;
  }
}
