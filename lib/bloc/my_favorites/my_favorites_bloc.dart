import 'package:bloc/bloc.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'my_favorites_state.dart';
import 'my_favorites_event.dart';

class MyFavoritesBloc extends Bloc<MyFavoritesEvent, MyFavoritesState> {
  MyFavoritesBloc() : super(const MyFavoritesLoading()) {
    on<MyFavoritesStarted>(_onStarted);
    on<AddRestaurantToFavorites>(_addRestaurant);
    on<RemoveRestaurantFromFavorites>(_removeRestaurant);
  }

  void _onStarted(
    MyFavoritesStarted event,
    Emitter<MyFavoritesState> emit,
  ) async {
    emit(const MyFavoritesLoading());
    try {
      emit(const MyFavoritesLoaded([]));
    } catch (_) {
      emit(MyFavoritesFetchError());
    }
  }

  void _addRestaurant(
    AddRestaurantToFavorites event,
    Emitter<MyFavoritesState> emit,
  ) {
    final state = this.state;
    if (state is MyFavoritesLoaded) {
      emit(MyFavoritesLoaded([...state.restaurants, event.restaurant]));
    }
  }

  void _removeRestaurant(
    RemoveRestaurantFromFavorites event,
    Emitter<MyFavoritesState> emit,
  ) {
    final state = this.state;
    if (state is MyFavoritesLoaded) {
      var restaurants = List<Restaurant>.from(state.restaurants)
        ..removeWhere(
          (Restaurant restaurant) => restaurant.id == event.restaurant.id,
        );

      emit(MyFavoritesLoaded(restaurants));
    }
  }
}
