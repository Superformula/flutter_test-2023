import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  Future<void> favoriteRestaurant(Restaurant restaurant) async {
    final newFavorites = List<Restaurant>.from(state.favorites);
    final isAlreadyFavorited = !state.favorites.any(
      (element) => element.id == restaurant.id,
    );
    if (restaurant.id != null) {
      if (isAlreadyFavorited) {
        newFavorites.add(restaurant);
        emit(state.copyWith(status: FavoriteStatus.favoriteSuccess));
        emit(
          state.copyWith(
            favorites: newFavorites,
            status: FavoriteStatus.success,
          ),
        );
      } else {
        newFavorites.remove(restaurant);

        if (newFavorites.isNotEmpty) {
          emit(
            state.copyWith(
              favorites: newFavorites,
              status: FavoriteStatus.removed,
            ),
          );

          emit(
            state.copyWith(
              favorites: newFavorites,
              status: FavoriteStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              favorites: newFavorites,
              status: FavoriteStatus.removed,
            ),
          );
          emit(state.copyWith(status: FavoriteStatus.initial));
        }
      }
    } else {
      emit(
        state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage:
              'Could favorite this restaurant! Refresh the app to try again! ',
        ),
      );
    }
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    if (state.favorites.isEmpty) {
      emit(
        state.copyWith(status: FavoriteStatus.initial),
      );
    } else {
      emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favorites: state.favorites,
        ),
      );
    }
  }
}
