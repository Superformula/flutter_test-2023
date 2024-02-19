import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

enum RestaurantStatus { loading, content, error, empty }

extension RestaurantStatusExt on RestaurantStatus {
  bool get isLoading => this == RestaurantStatus.loading;
  bool get isError => this == RestaurantStatus.error;
  bool get isEmpty => this == RestaurantStatus.empty;
}

enum FavoriteStatus { loading, content, error, empty }

extension FavoriteStatusExt on FavoriteStatus {
  bool get isLoading => this == FavoriteStatus.loading;
  bool get isError => this == FavoriteStatus.error;
  bool get isEmpty => this == FavoriteStatus.empty;
}

class RestaurantsViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final FavoriteService favoritesService;
  RestaurantsViewModel({required this.favoritesService, required this.restaurantRepository});

  RestaurantStatus restaurantStatus = RestaurantStatus.loading;
  FavoriteStatus favoriteStatus = FavoriteStatus.loading;

  RestaurantQueryResult? _restaurants;
  List<Restaurant> _favorites = [];

  List<Restaurant> get favoritesRestaurantList => _favorites;
  List<Restaurant> get restaurantsList => _restaurants?.restaurants ?? [];

  Future<void> load() async {
    await loadRestaurants();
    await loadFavorites();
  }

  Future<void> loadRestaurants() async {
    try {
      _emitRestaurantLoading();
      _restaurants = await restaurantRepository.getRestaurants();
      restaurantsList.isEmpty ? _emitRestaurantEmpty() : _emitRestaurantContent();
    } catch (e) {
      print(e);
      _emitRestaurantError();
    }
  }

  Future<void> loadFavorites() async {
    try {
      _emitFavoriteLoading();
      _favorites = [];
      final favoritesIds = await favoritesService.loadFavorites();
      _favorites = restaurantsList.where((restaurant) => favoritesIds.contains(restaurant.id)).toList();
      _favorites.isEmpty ? _emitFavoriteEmpty() : _emitFavoriteContent();
    } catch (e) {
      print(e);
      _emitFavoriteError();
    }
  }

  void _emitRestaurantContent() {
    restaurantStatus = RestaurantStatus.content;
    notifyListeners();
  }

  void _emitRestaurantLoading() {
    restaurantStatus = RestaurantStatus.loading;
    notifyListeners();
  }

  void _emitRestaurantError() {
    restaurantStatus = RestaurantStatus.error;
    notifyListeners();
  }

  void _emitRestaurantEmpty() {
    restaurantStatus = RestaurantStatus.empty;
    notifyListeners();
  }

  void _emitFavoriteContent() {
    favoriteStatus = FavoriteStatus.content;
    notifyListeners();
  }

  void _emitFavoriteLoading() {
    favoriteStatus = FavoriteStatus.loading;
    notifyListeners();
  }

  void _emitFavoriteError() {
    favoriteStatus = FavoriteStatus.error;
    notifyListeners();
  }

  void _emitFavoriteEmpty() {
    favoriteStatus = FavoriteStatus.empty;
    notifyListeners();
  }
}
