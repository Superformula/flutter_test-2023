import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/core/logger.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';

enum FavoritesStatus { loading, content, error, empty }

extension FavoritesStatusExt on FavoritesStatus {
  bool get isLoading => this == FavoritesStatus.loading;
  bool get isError => this == FavoritesStatus.error;
  bool get isEmpty => this == FavoritesStatus.empty;
}

class FavoritesViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final FavoriteService favoritesService;
  final EventBusService eventBus;

  final List<RestaurantDto> _restaurantsCache = [];

  FavoritesViewModel({required this.favoritesService, required this.restaurantRepository, required this.eventBus}) {
    _init();
  }

  FavoritesStatus status = FavoritesStatus.loading;

  RestaurantQueryResultDto? _restaurantsQuery;
  List<RestaurantDto> _favorites = [];

  int get allRestaurantsQueryTotal => _restaurantsQuery?.total ?? 0;
  List<RestaurantDto> get favoritesRestaurantList => _favorites;
  List<RestaurantDto> get restaurantsList => _restaurantsQuery?.restaurants ?? [];

  Future<void> _init() async {
    eventBus.stream.listen((event) => loadFavorites());
    await loadRestaurants();
    await loadFavorites();
  }

  Future<void> loadRestaurants() async {
    try {
      _emitLoading();
      _restaurantsQuery = await restaurantRepository.getRestaurants();
      restaurantsList.isEmpty ? _emitEmpty() : _emitContent();
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load Restaurants', exception: exception, stackTrace: stackTrace);
      _emitError();
    }
  }

  Future<void> loadFavorites() async {
    try {
      _emitLoading();
      final favoritesIds = await favoritesService.getFavorites();

      _favorites = restaurantsList.where((restaurant) => favoritesIds.contains(restaurant.id)).toList();
      final favoritesToFetchInCache = await _findFavoritesNotLoadedInMemory(inMemory: restaurantsList, favoritesIds: favoritesIds);

      _favorites.addAll(_restaurantsCache.where((restaurant) => favoritesToFetchInCache.contains(restaurant.id)).toList());
      final favoritesToFetch = await _findFavoritesNotLoadedInMemory(inMemory: _restaurantsCache, favoritesIds: favoritesIds);

      await _loadFavoritesInMemory(favoritesToFetch);
      _favorites.isEmpty ? _emitEmpty() : _emitContent();
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load Favorites', exception: exception, stackTrace: stackTrace);
      _emitError();
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
      RTLogger.w(message: 'Loading single favorite $favoriteId');
      final _restaurant = await restaurantRepository.getSingleRestaurant(restaurantId: favoriteId);
      _favorites.add(_restaurant);
      _restaurantsCache.add(_restaurant);
    } catch (exception, stackTrace) {
      RTLogger.e(message: 'Fail to load detail of Favorite', exception: exception, stackTrace: stackTrace);
      _favorites.add(RestaurantDto(id: favoriteId));
    }
  }

  void _emitContent() {
    status = FavoritesStatus.content;
    notifyListeners();
  }

  void _emitLoading() {
    status = FavoritesStatus.loading;
    notifyListeners();
  }

  void _emitError() {
    status = FavoritesStatus.error;
    notifyListeners();
  }

  void _emitEmpty() {
    status = FavoritesStatus.empty;
    notifyListeners();
  }
}
