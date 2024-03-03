import 'package:flutter/foundation.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/use_cases/save_favorite_restaurant_use_case.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  RestaurantDetailViewModel({
    required RestaurantEntity restaurant,
    required SaveFavoriteRestaurantUseCase saveFavoriteRestaurantUseCase,
  })  : _restaurant = restaurant,
        _saveFavoriteRestaurantUseCase = saveFavoriteRestaurantUseCase;

  final RestaurantEntity _restaurant;
  final SaveFavoriteRestaurantUseCase _saveFavoriteRestaurantUseCase;

  void addToFavorites() {
    _saveFavoriteRestaurantUseCase(_restaurant.id);
    notifyListeners();
  }
}
