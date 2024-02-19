import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

enum RestaurantListStatus { loading, content, error, empty }

extension RestaurantListStatusExt on RestaurantListStatus {
  bool get isLoading => this == RestaurantListStatus.loading;
  bool get isError => this == RestaurantListStatus.error;
  bool get isEmpty => this == RestaurantListStatus.empty;
}

enum RestaurantFavoriteListStatus { loading, content, error, empty }

extension RestaurantFavoriteListStatusExt on RestaurantFavoriteListStatus {
  bool get isLoading => this == RestaurantFavoriteListStatus.loading;
  bool get isError => this == RestaurantFavoriteListStatus.error;
  bool get isEmpty => this == RestaurantFavoriteListStatus.empty;
}

class RestaurantListViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final FavoritesService favoritesService;
  RestaurantListViewModel({required this.favoritesService, required this.restaurantRepository});

  RestaurantListStatus restaurantListStatus = RestaurantListStatus.loading;
  RestaurantFavoriteListStatus restaurantFavoriteListStatus = RestaurantFavoriteListStatus.loading;

  RestaurantQueryResult? _restaurants;
  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;
  List<Restaurant> get restaurants => _restaurants?.restaurants ?? [];

  Future<void> load() async {
    await loadRestaurants();
    await loadFavorites();
  }

  Future<void> loadRestaurants() async {
    try {
      _emitRestaurantListLoading();
      _restaurants = await restaurantRepository.getRestaurants();
      restaurants.isEmpty ? _emitRestaurantListEmpty() : _emitRestaurantListContent();
    } catch (e) {
      print(e);
      _emitRestaurantListError();
    }
  }

  Future<void> loadFavorites() async {
    try {
      _emitRestaurantFavoriteListLoading();
      _favorites = [];
      final favoritesIds = await favoritesService.loadFavorites();
      _favorites = restaurants.where((restaurant) => favoritesIds.contains(restaurant.id)).toList();
      _favorites.isEmpty ? _emitRestaurantFavoriteListEmpty() : _emitRestaurantFavoriteListContent();
    } catch (e) {
      print(e);
      _emitRestaurantFavoriteListError();
    }
  }

  void _emitRestaurantListContent() {
    restaurantListStatus = RestaurantListStatus.content;
    notifyListeners();
  }

  void _emitRestaurantListLoading() {
    restaurantListStatus = RestaurantListStatus.loading;
    notifyListeners();
  }

  void _emitRestaurantListError() {
    restaurantListStatus = RestaurantListStatus.error;
    notifyListeners();
  }

  void _emitRestaurantListEmpty() {
    restaurantListStatus = RestaurantListStatus.empty;
    notifyListeners();
  }

  void _emitRestaurantFavoriteListContent() {
    restaurantFavoriteListStatus = RestaurantFavoriteListStatus.content;
    notifyListeners();
  }

  void _emitRestaurantFavoriteListLoading() {
    restaurantFavoriteListStatus = RestaurantFavoriteListStatus.loading;
    notifyListeners();
  }

  void _emitRestaurantFavoriteListError() {
    restaurantFavoriteListStatus = RestaurantFavoriteListStatus.error;
    notifyListeners();
  }

  void _emitRestaurantFavoriteListEmpty() {
    restaurantFavoriteListStatus = RestaurantFavoriteListStatus.empty;
    notifyListeners();
  }
}
