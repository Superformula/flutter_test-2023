import 'package:flutter/material.dart';
import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/local_db.dart';

class FavoriteModel with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  final List<Restaurant> _favoriteRestaurants = [];
  LocalDB localDB = LocalDB.instance;

  FavoriteModel() {
    getRestaurants();
  }

  void getRestaurants() async {
    final localDB = LocalDB.instance;
    final savedRestaurant = await localDB.readRestaurants();
    if (savedRestaurant.isNotEmpty) {
      _restaurants = (savedRestaurant as List<dynamic>)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      var response = await RestaurantService.getRestaurants();
      if (response is Success) {
        _restaurants = response.response as List<Restaurant>;
      }
    }

    getFavorites();
  }

  getFavorites() async {
    List<String>? favoriteList = await localDB.favoriteList;

    if (favoriteList != null) {
      for (var element in _restaurants) {
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
          .add(_restaurants.firstWhere((element) => element.id == id));
    }
    notifyListeners();
  }

  List<Restaurant> get favoriteRestaurants => _favoriteRestaurants;
}
