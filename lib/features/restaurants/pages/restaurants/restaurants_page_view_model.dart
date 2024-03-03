import 'package:flutter/material.dart';
import 'package:restaurantour/core/logger.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';

enum RestaurantsStatus { paginating, loading, content, error, empty }

extension RestaurantsStatusExt on RestaurantsStatus {
  bool get isLoading => this == RestaurantsStatus.loading;
  bool get isPaginating => this == RestaurantsStatus.paginating;
  bool get isError => this == RestaurantsStatus.error;
  bool get isEmpty => this == RestaurantsStatus.empty;
}

class RestaurantsViewModel with ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  final int paginationSize = 20;

  RestaurantsViewModel({required this.restaurantRepository}) {
    _init();
  }

  RestaurantsStatus restaurantsStatus = RestaurantsStatus.loading;

  RestaurantQueryResultDto? _restaurantsQuery;

  int get allRestaurantsQueryTotal => _restaurantsQuery?.total ?? 0;

  List<RestaurantDto> get restaurantsList => _restaurantsQuery?.restaurants ?? [];
  bool get shouldPaginate => restaurantsList.length < allRestaurantsQueryTotal && allRestaurantsQueryTotal > paginationSize;

  Future<void> _init() async {
    await loadRestaurants();
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
}
