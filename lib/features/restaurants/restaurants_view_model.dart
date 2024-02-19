import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

enum RestaurantsStatus { paginating, loading, content, error, empty }

extension RestaurantsStatusExt on RestaurantsStatus {
  bool get isLoading => this == RestaurantsStatus.loading;
  bool get isPaginating => this == RestaurantsStatus.paginating;
  bool get isError => this == RestaurantsStatus.error;
  bool get isEmpty => this == RestaurantsStatus.empty;
}

enum FavoritesStatus { loading, content, error, empty }

extension FavoritesStatusExt on FavoritesStatus {
  bool get isLoading => this == FavoritesStatus.loading;
  bool get isError => this == FavoritesStatus.error;
  bool get isEmpty => this == FavoritesStatus.empty;
}

class RestaurantsViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final FavoriteService favoritesService;
  final int paginationSize = 20;
  RestaurantsViewModel({required this.favoritesService, required this.restaurantRepository});

  RestaurantsStatus restaurantsStatus = RestaurantsStatus.loading;
  FavoritesStatus favoritesStatus = FavoritesStatus.loading;

  RestaurantQueryResult? _restaurantsQuery;
  List<Restaurant> _favorites = [];

  int get allRestaurantsQueryTotal => _restaurantsQuery?.total ?? 0;
  List<Restaurant> get favoritesRestaurantList => _favorites;
  List<Restaurant> get restaurantsList => _restaurantsQuery?.restaurants ?? [];
  bool get shouldPaginate => restaurantsList.length < allRestaurantsQueryTotal && allRestaurantsQueryTotal > paginationSize;

  Future<void> load() async {
    await loadRestaurants();
    await loadFavorites();
  }

  Future<void> loadRestaurants() async {
    try {
      _emitRestaurantLoading();
      _restaurantsQuery = await restaurantRepository.getRestaurants();
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

  Future<void> paginateRestaurants() async {
    if (restaurantsStatus.isPaginating || !shouldPaginate) return;
    try {
      _emitRestaurantPaginating();
      final paginated = await restaurantRepository.getRestaurants(offset: restaurantsList.length);
      restaurantsList.addAll(paginated?.restaurants ?? []);
    } catch (e) {
      print(e);
    } finally {
      _emitRestaurantContent();
    }
  }

  void _emitRestaurantContent() {
    restaurantsStatus = RestaurantsStatus.content;
    notifyListeners();
  }

  void _emitRestaurantLoading() {
    restaurantsStatus = RestaurantsStatus.loading;
    notifyListeners();
  }

  void _emitRestaurantPaginating() {
    restaurantsStatus = RestaurantsStatus.paginating;
    notifyListeners();
  }

  void _emitRestaurantError() {
    restaurantsStatus = RestaurantsStatus.error;
    notifyListeners();
  }

  void _emitRestaurantEmpty() {
    restaurantsStatus = RestaurantsStatus.empty;
    notifyListeners();
  }

  void _emitFavoriteContent() {
    favoritesStatus = FavoritesStatus.content;
    notifyListeners();
  }

  void _emitFavoriteLoading() {
    favoritesStatus = FavoritesStatus.loading;
    notifyListeners();
  }

  void _emitFavoriteError() {
    favoritesStatus = FavoritesStatus.error;
    notifyListeners();
  }

  void _emitFavoriteEmpty() {
    favoritesStatus = FavoritesStatus.empty;
    notifyListeners();
  }
}
