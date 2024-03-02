import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/restaurant_repository.dart';

class FavoriteRestaurantsCubit extends Cubit<List<Restaurant>> {
  FavoriteRestaurantsCubit(this._repository) : super([]);

  final RestaurantRepository _repository;

  void updateFavoriteRestaurants(List<Restaurant> restaurants) {
    final favorites = restaurants
        .where(
          (restaurant) =>
              _repository.checkFavoriteRestaurant(restaurant.id ?? ''),
        )
        .toList();
    emit(favorites);
  }

  void updateFavoriteRestaurant(Restaurant restaurant) {
    if (state.contains(restaurant)) {
      emit(state..remove(restaurant));
    } else {
      emit(state..add(restaurant));
    }
  }

  void checkForChanges() => emit(List.from(state));
}
