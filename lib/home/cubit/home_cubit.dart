import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/models/restaurant.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadAllRestaurants() async {
    try {
      // await Future.delayed(const Duration(seconds: 2));
      // TODO: load all restaurants from the server and replace error
      // throw Exception('Error loading restaurants');
      emit(
        state.copyWith(
          allRestaurants: [],
          allRestaurantsStatus: HomeListStatus.loaded,
        ),
      );
    } catch (e) {
      state.copyWith(
        allRestaurantsStatus: HomeListStatus.error,
      );
    }
  }

  Future<void> loadFavorites() async {
    try {
      // await Future.delayed(const Duration(seconds: 2));
      // TODO: load all restaurants from the server and replace error
      // throw Exception('Error loading favorites');
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
