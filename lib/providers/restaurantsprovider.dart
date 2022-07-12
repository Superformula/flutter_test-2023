/// Copyright 2022 - Superformula. All rights reserved.
import 'package:flutter/material.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/models/restaurant.dart';

/// This is a Provider clss which extends ChangeNotifies to mange the Sate for the Restaurants.
class RestaurantsProvider extends ChangeNotifier {
  final _yelpRepo = YelpRepository();
  bool _firstLoading = true;
  final int _perPageRecords = 6;

  List _allRestaurantsList = [];

  Map<String?, Restaurant> _allRestaurants = {};

  Map<String?, bool> _restMap = {};

  Map get allRestaurantsMap => _allRestaurants;
  Map get allFavouriteRestaurants => _restMap;
  bool get isFirstLoading => _firstLoading;
  int get allRestaurantsListCount => _allRestaurantsList.length;

  /// Load all Restaurants from the given Yelp API
  /// If the given listener is not registered, the call is ignored.
  /// This method must not be called after [dispose] has been called.
  ///

  void loadAllRestaurants() async {
    final restaurantQueryResult = await _yelpRepo.getRestaurants();
    if (restaurantQueryResult != null) {
      _allRestaurantsList = restaurantQueryResult.restaurants!;
      loadInitialRestaurants();
    }
    _firstLoading = false;
    notifyListeners();
  }

  /// Load Initial Restaurants from the All restaurants Map -
  /// All Restaurants Map should be loaded before loadInitialRestaurants
  /// If the given listener is not registered, the call is ignored.
  /// This method will be useful for the pagination

  loadInitialRestaurants() {
    var rCount = _allRestaurantsList.length > _perPageRecords ? _perPageRecords : _allRestaurantsList.length;
    for (var i = 0; i < rCount; i++) {
      var restaurant = _allRestaurantsList[i];
      _allRestaurants[restaurant.id] = restaurant;
    }
  }

  /// Load More Restaurants from the All restaurants Map -
  /// All Restaurants Map should be loaded before loadInitialRestaurants
  /// If the given listener is not registered, the call is ignored.
  /// This method will be useful for the pagination

  void loadMoreRestaurants() {
    var rCount = _allRestaurantsList.length > (_perPageRecords + _allRestaurants.length)
        ? (_perPageRecords + _allRestaurants.length)
        : _allRestaurantsList.length;
    for (var i = _allRestaurants.length; i < rCount; i++) {
      var restaurant = _allRestaurantsList[i];
      _allRestaurants[restaurant.id] = restaurant;
    }
    notifyListeners();
  }

  /// Add Favourite Restaurants from the All restaurants Map to the allFavouriteRestaurantsMap
  /// All Restaurants Map should be loaded before loadInitialRestaurants
  /// If the given listener is not registered, the call is ignored.
  /// This method will be called in the Favourite Restaurants Tab

  void addFavourateRestaurant(String restaurantId) {
    if (!_restMap.containsKey(restaurantId)) {
      _restMap[restaurantId] = true;
    }
    notifyListeners();
  }

  /// Remove Favourite Restaurants from the allFavouriteRestaurantsMap
  /// All Restaurants Map should be loaded before loadInitialRestaurants
  /// If the given listener is not registered, the call is ignored.
  /// This method will be called in the Favourite Restaurants Tab

  void removeFavourateRestaurant(String restaurantId) {
    if (_restMap.containsKey(restaurantId)) {
      _restMap.remove(restaurantId);
    }
    notifyListeners();
  }
}
