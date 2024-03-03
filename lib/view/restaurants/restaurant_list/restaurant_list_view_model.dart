import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';

enum RestaurantListState {
  loading,
  loadingMore,
  loaded,
  error,
}

class RestaurantListViewModel extends ChangeNotifier {
  final GetRestaurantsUseCase _getRestaurantsUseCase;
  final WatchFavoriteRestaurantsUseCase _watchFavoriteRestaurantsUseCase;

  RestaurantListViewModel(
    this._getRestaurantsUseCase,
    this._watchFavoriteRestaurantsUseCase,
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

  StreamSubscription<List<String>>? _favoritesSubscription;

  void init() {
    getRestaurants();
    _favoritesSubscription?.cancel();
    _favoritesSubscription = _watchFavoriteRestaurantsUseCase().listen((event) {
      _favoriteRestaurants = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _favoritesSubscription?.cancel();
  }

  Future<List<RestaurantEntity>?> getRestaurants() async {
    try {
      if (_state == RestaurantListState.loadingMore) return _restaurants;

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
