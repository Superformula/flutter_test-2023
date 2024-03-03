import 'package:flutter/foundation.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurant_favorite_status_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/toggle_favorite_restaurant_use_case.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  RestaurantDetailViewModel(
    this._toggleFavoriteRestaurantUseCase,
    this._getRestaurantFavoriteStatusUseCase,
  );

  final ToggleFavoriteRestaurantUseCase _toggleFavoriteRestaurantUseCase;
  final GetRestaurantFavoriteStatusUseCase _getRestaurantFavoriteStatusUseCase;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  RestaurantEntity? _restaurant;
  RestaurantEntity? get restaurant => _restaurant;

  init(RestaurantEntity restaurant) {
    _restaurant = restaurant;
    getFavoriteStatus();
  }

  void getFavoriteStatus() async {
    if (_restaurant == null) return;
    _isFavorite = await _getRestaurantFavoriteStatusUseCase(_restaurant!.id);
    notifyListeners();
  }

  void toggleFavorite() async {
    if (_restaurant == null) return;
    await _toggleFavoriteRestaurantUseCase(_restaurant!.id);
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
