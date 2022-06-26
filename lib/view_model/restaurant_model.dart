import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:restaurantour/api/restaurant_service.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantModel extends ChangeNotifier {
  bool _isLoading = true;
  int _listCount = 7;
  List<Restaurant> _restaurants = [];
  Failure? _error;

  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult _connectionStatus;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  RestaurantModel() {
    getRestaurants();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status ${e.toString()}');
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (result == ConnectivityResult.none) {
      _error = Failure(response: "Please check your internet connection.");
    }
    notifyListeners();
  }

  cancelSubscription() {
    _connectivitySubscription.cancel();
  }

  Connectivity get connectivity => _connectivity;

  ConnectivityResult get connectionStatus => _connectionStatus;

  bool get isLoading => _isLoading;

  int get listCount => _listCount;

  List<Restaurant> get restaurants => _restaurants;

  Failure? get error => _error;
}
