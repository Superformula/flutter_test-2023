import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

enum RestaurantListStatus { loading, content, error, favoriteError }

extension RestaurantListStatusExt on RestaurantListStatus {
  bool get isLoading => this == RestaurantListStatus.loading;
  bool get isError => this == RestaurantListStatus.error;
  bool get isFavoriteError => this == RestaurantListStatus.favoriteError;
}

class RestaurantListViewModel with ChangeNotifier {
  final YelpRepository yelpRepo;
  final FavoritesService favoritesService;
  RestaurantListViewModel({required this.favoritesService, required this.yelpRepo});

  RestaurantListStatus status = RestaurantListStatus.loading;
  RestaurantQueryResult? _restaurants;
  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;
  List<Restaurant> get restaurants => _restaurants?.restaurants ?? [];

  Future<void> load() async {
    try {
      _emitLoading();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      _restaurants = await yelpRepo.getRestaurants();
      _emitContent();
    } catch (e) {
      print(e);
      _emitError();
    }
  }

  Future<void> loadFavorites() async {
    try {
      _emitLoading();
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _favorites = [];
      final favoritesIds = await favoritesService.loadFavorites();
      _favorites = restaurants.where((restaurant) => favoritesIds.contains(restaurant.id)).toList();

      _emitContent();
    } catch (e) {
      print(e);
      _emitFavoriteError();
    }
  }

  void _emitContent() {
    status = RestaurantListStatus.content;
    notifyListeners();
  }

  void _emitLoading() {
    status = RestaurantListStatus.loading;
    notifyListeners();
  }

  void _emitError() {
    status = RestaurantListStatus.error;
    notifyListeners();
  }

  void _emitFavoriteError() {
    status = RestaurantListStatus.favoriteError;
    notifyListeners();
  }
}
