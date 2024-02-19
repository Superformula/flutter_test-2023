import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_state.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/errors/not_found_exception.dart';
import 'package:restaurantour/models/favorites.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurants/restaurants_repository.dart';

class HomeViewmodel extends Cubit<HomeState> {
  HomeViewmodel(this.repository, this.sharedPreferencesService)
      : super(InitialState());
  final RestaurantsRepository repository;
  RestaurantQueryResult restaurants = const RestaurantQueryResult();

  RestaurantQueryResult favoriteRestaurants =
      // ignore: prefer_const_constructors
      RestaurantQueryResult(restaurants: []);

  final SharedPreferencesService sharedPreferencesService;
  Favorites fav = Favorites(ids: ['']);

  Future<void> fetchRestaurants() async {
    try {
      emit(LoadingState());
      restaurants = await repository.getRestaurants();
      emit(LoadedState());
    } on NotFoundException catch (e) {
      emit(ErrorState(e.message ?? ''));
    }
  }
}
