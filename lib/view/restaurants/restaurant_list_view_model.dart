import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';

enum RestaurantListState {
  loading,
  loadingMore,
  loaded,
  error,
}

class RestaurantListViewModel extends ChangeNotifier {
  final GetRestaurantsUseCase _getRestaurantsUseCase;

  RestaurantListViewModel(
    this._getRestaurantsUseCase,
  );

  final List<RestaurantEntity> _restaurants = [];
  List<RestaurantEntity> get restaurants => _restaurants;

  List<String>? _favoriteRestaurants;
  List<String> get favoriteRestaurants => _favoriteRestaurants ?? [];

  RestaurantListState _state = RestaurantListState.loading;
  bool get hasError => _state == RestaurantListState.error;
  bool get isLoading => _state == RestaurantListState.loading;
  bool get hasData => _state == RestaurantListState.loaded;

  int _offset = 0;

  void init() {
    fetchRestaurants();
  }

  Future<List<RestaurantEntity>?> fetchRestaurants() async {
    try {
      if (_state == RestaurantListState.loadingMore) return _restaurants;
      print('fetching restaurants');

      final result = await _getRestaurantsUseCase(_offset);
      _restaurants.addAll(result);
      _offset += result.length;
      _state = RestaurantListState.loaded;
      notifyListeners();
      return result;
    } catch (e) {
      _state = RestaurantListState.error;
      notifyListeners();
      return null;
    }
  }
}
