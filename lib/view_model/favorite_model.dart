import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/local_db.dart';
import 'package:restaurantour/view_model/restaurant_handler.dart';

class FavoriteModel extends RestaurantHandler with ChangeNotifier {
  final List<Restaurant> _favoriteRestaurants = [];
  LocalDB localDB = LocalDB.instance;

  FavoriteModel() {
    getRestaurants();
  }

  void getRestaurants() async {
    final localDB = LocalDB.instance;
    final savedRestaurant = await localDB.readRestaurants();
    if (savedRestaurant != null && savedRestaurant.isNotEmpty) {
      restaurants = (savedRestaurant as List<dynamic>)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      await requestRestaurant();
    }

    getFavorites();
  }

  getFavorites() async {
    List<String>? favoriteList = await localDB.favoriteList;

    if (favoriteList != null && restaurants.isNotEmpty) {
      for (var element in restaurants) {
        if (favoriteList.contains(element.id)) {
          _favoriteRestaurants.add(element);
        }
      }
    }
    notifyListeners();
  }

  updateFavorites(String id, bool newFavorite) async {
    await localDB.updateFavorite(id, newFavorite);
    if (!newFavorite) {
      _favoriteRestaurants.removeWhere((element) => element.id == id);
    } else {
      _favoriteRestaurants
          .add(restaurants.firstWhere((element) => element.id == id));
    }
    notifyListeners();
  }

  List<Restaurant> get favoriteRestaurants => _favoriteRestaurants;
}
