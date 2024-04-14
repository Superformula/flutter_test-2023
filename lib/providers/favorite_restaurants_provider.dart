import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/models/restaurant.dart';

class FavoritesNotifier extends StateNotifier<List<Restaurant>> {
  FavoritesNotifier() : super([]);

  void addFavorite(Restaurant restaurant) {
    if (!state.contains(restaurant)) {
      state = [...state, restaurant];
    }
  }

  void removeFavorite(Restaurant restaurant) {
    state = state.where((r) => r.id != restaurant.id).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Restaurant>>((ref) {
  return FavoritesNotifier();
});
