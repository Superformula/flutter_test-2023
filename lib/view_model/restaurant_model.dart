import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantModel extends ChangeNotifier {
  bool _isLoading = true;
  int _listCount = 7;
  List<Restaurant> _restaurants = [];
  Failure? _error;

  RestaurantModel() {
    getRestaurants();
  }

  void increaseListCount() {
    _listCount = min(_listCount + 7, _restaurants.length);
    notifyListeners();
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void getRestaurants() async {
    setLoading(true);
    var response = await RestaurantService.getRestaurants();
    if (response is Success) {
      _restaurants = response.response as List<Restaurant>;
    }
    if (response is Failure) {
      _error = response;
    }
    setLoading(false);
  }

  bool get isLoading => _isLoading;

  int get listCount => _listCount;

  List<Restaurant> get restaurants => _restaurants;

  Failure? get error => _error;
}
