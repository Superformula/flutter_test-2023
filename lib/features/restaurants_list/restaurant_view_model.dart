import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

enum RestaurantListStatus { loading, content, error, favoritesEmpty, restaurantsEmpty, favoritesError }

extension RestaurantListStatusExt on RestaurantListStatus {
  bool get isLoading => this == RestaurantListStatus.loading;
  bool get isError => this == RestaurantListStatus.error;
  bool get isFavoritesEmpty => this == RestaurantListStatus.favoritesEmpty;
  bool get isRestaurantsEmpty => this == RestaurantListStatus.restaurantsEmpty;
  bool get isFavoritesError => this == RestaurantListStatus.favoritesError;
}

class RestaurantListViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final FavoritesService favoritesService;
  RestaurantListViewModel({required this.favoritesService, required this.restaurantRepository});

  RestaurantListStatus status = RestaurantListStatus.loading;
  RestaurantQueryResult? _restaurants;
  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;
  List<Restaurant> get restaurants => _restaurants?.restaurants ?? [];

  Future<void> load() async {
    try {
      _emitLoading();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      _restaurants = await restaurantRepository.getRestaurants();

      restaurants.isEmpty ? _emitRestaurantsEmpty() : _emitContent();
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
      _favorites.isEmpty ? _emitFavoritesEmpty() : _emitContent();
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
    status = RestaurantListStatus.favoritesError;
    notifyListeners();
  }

  void _emitRestaurantsEmpty() {
    status = RestaurantListStatus.restaurantsEmpty;
    notifyListeners();
  }

  void _emitFavoritesEmpty() {
    status = RestaurantListStatus.favoritesEmpty;
    notifyListeners();
  }
}
