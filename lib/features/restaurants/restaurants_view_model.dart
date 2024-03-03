import 'package:flutter/material.dart';
import 'package:restaurantour/core/logger.dart';
import 'package:restaurantour/models/dto.dart';
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

  final List<RestaurantDto> _restaurantsCache = [];

  RestaurantsViewModel({required this.favoritesService, required this.restaurantRepository});

  RestaurantsStatus restaurantsStatus = RestaurantsStatus.loading;
  FavoritesStatus favoritesStatus = FavoritesStatus.loading;

  RestaurantQueryResultDto? _restaurantsQuery;
  List<RestaurantDto> _favorites = [];

  int get allRestaurantsQueryTotal => _restaurantsQuery?.total ?? 0;
  List<RestaurantDto> get favoritesRestaurantList => _favorites;
  List<RestaurantDto> get restaurantsList => _restaurantsQuery?.restaurants ?? [];
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
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load Restaurants', exception: exception, stackTrace: stackTrace);
      _emitRestaurantError();
    }
  }

  Future<void> paginateRestaurants() async {
    if (restaurantsStatus.isPaginating || !shouldPaginate) return;
    try {
      _emitRestaurantPaginating();
      final paginated = await restaurantRepository.getRestaurants(offset: restaurantsList.length);
      restaurantsList.addAll(paginated?.restaurants ?? []);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to paginate Restaurants', exception: exception, stackTrace: stackTrace);
    } finally {
      _emitRestaurantContent();
    }
  }

  Future<void> loadFavorites() async {
    try {
      _emitFavoriteLoading();
      final favoritesIds = await favoritesService.loadFavorites();

      _favorites = restaurantsList.where((restaurant) => favoritesIds.contains(restaurant.id)).toList();
      final favoritesToFetchInCache = await _findFavoritesNotLoadedInMemory(inMemory: restaurantsList, favoritesIds: favoritesIds);

      _favorites.addAll(_restaurantsCache.where((restaurant) => favoritesToFetchInCache.contains(restaurant.id)).toList());
      final favoritesToFetch = await _findFavoritesNotLoadedInMemory(inMemory: _restaurantsCache, favoritesIds: favoritesIds);

      await _loadFavoritesInMemory(favoritesToFetch);
      _favorites.isEmpty ? _emitFavoriteEmpty() : _emitFavoriteContent();
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load Favorites', exception: exception, stackTrace: stackTrace);
      _emitFavoriteError();
    }
  }

  Future<List<String>> _findFavoritesNotLoadedInMemory({required List<RestaurantDto> inMemory, required List<String> favoritesIds}) async {
    inMemory.map((restaurant) {
      if (favoritesIds.contains(restaurant.id)) favoritesIds.remove(restaurant.id);
    }).toList();
    return favoritesIds;
  }

  Future<void> _loadFavoritesInMemory(List<String> favorites) async {
    List<Future> loadFavoritesList = [];
    for (var favoriteId in favorites) {
      loadFavoritesList.add(_loadSingleFavorite(favoriteId));
    }
    await Future.wait(loadFavoritesList);
  }

  Future<void> _loadSingleFavorite(String favoriteId) async {
    try {
      final _restaurant = await restaurantRepository.getSingleRestaurant(restaurantId: favoriteId);
      _favorites.add(_restaurant);
      _restaurantsCache.add(_restaurant);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load detail of Favorite', exception: exception, stackTrace: stackTrace);
      _favorites.add(RestaurantDto(id: favoriteId));
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
