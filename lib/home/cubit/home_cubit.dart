import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required RestaurantRepository restaurantRepository})
      : _restaurantRepository = restaurantRepository,
        super(const HomeState()) {
    _restaurantsSubscription =
        _restaurantRepository.restaurants.listen(_onRestaurantsLoaded);
  }
  late StreamSubscription<List<Restaurant>> _restaurantsSubscription;
  final RestaurantRepository _restaurantRepository;

  @override
  Future<void> close() {
    _restaurantsSubscription.cancel();
    return super.close();
  }

  void _onRestaurantsLoaded(List<Restaurant> restaurants) {
    if (restaurants.isEmpty) {
      emit(state.copyWith(allRestaurantsStatus: HomeListStatus.completed));
    }
    emit(
      state.copyWith(
        allRestaurantsStatus: HomeListStatus.loaded,
        offset: state.offset + restaurants.length,
        allRestaurants: restaurants,
      ),
    );
  }

  Future<void> loadAllRestaurants() async {
    try {
      if (state.allRestaurantsStatus != HomeListStatus.initial) {
        emit(state.copyWith(allRestaurantsStatus: HomeListStatus.loading));
      }
      _restaurantRepository.getRestaurants();
    } catch (e) {
      state.copyWith(
        allRestaurantsStatus: HomeListStatus.error,
      );
    }
  }

  Future<void> loadFavorites() async {
    try {
      emit(
        state.copyWith(
          favorites: [],
          favoritesStatus: HomeListStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          favoritesStatus: HomeListStatus.error,
        ),
      );
    }
  }
}
