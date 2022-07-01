import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/view_model/restaurant_handler.dart';

class RestaurantModel extends RestaurantHandler with ChangeNotifier {
  bool _isLoading = true;
  int _listCount = 7;

  RestaurantModel({List<Restaurant>? restaurants})
      : super(restaurants: restaurants) {
    // set up for widget test.
    if (restaurants != null) {
      _isLoading = false;
    } else {
      getRestaurants();
    }
  }

  void increaseListCount() {
    _listCount = min(_listCount + 7, restaurants.length);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getRestaurants() async {
    setLoading(true);
    await requestRestaurant();
    setLoading(false);
  }

  bool get isLoading => _isLoading;

  int get listCount => _listCount;
}
