import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  Future<void> favoriteRestaurant(Restaurant restaurant) async {
    if (restaurant.id != null) {
      if (!state.favorites.contains(restaurant.id)) {
        state.favorites.add(restaurant);
        emit(
          state.copyWith(
            favorites: state.favorites,
            status: FavoriteStatus.success,
          ),
        );
      } else {
        state.favorites.remove(restaurant);
        emit(
          state.copyWith(
            favorites: state.favorites,
            status: FavoriteStatus.removed,
          ),
        );
      }
    }
  }
}
