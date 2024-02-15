import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/restaurant.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();
  static late final SharedPreferences sharedPreferences;

  factory SharedPreferencesHelper() => instance;

  SharedPreferencesHelper._();

  static Future<void> initializeSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> cacheRestaurants(List<Restaurant> restaurants) async {
    String jsonString = jsonEncode(
        restaurants.map((restaurant) => restaurant.toJson()).toList());
    await sharedPreferences.setString('restaurants', jsonString);
  }

  Future<List<Restaurant>> getRestaurants() async {
    String? jsonString = sharedPreferences.getString('restaurants');
    if (jsonString == null) return [];
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse
        .map((restaurantMap) => Restaurant.fromJson(restaurantMap))
        .toList();
  }
}
