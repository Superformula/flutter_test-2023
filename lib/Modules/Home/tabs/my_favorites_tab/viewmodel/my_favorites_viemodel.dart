import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Home/tabs/my_favorites_tab/viewmodel/my_favorites_state.dart';
import 'package:restaurantour/Modules/Home/viewmodel/home_viewmodel.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_keys.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/models/favorites.dart';
import 'package:restaurantour/models/restaurant.dart';

class MyFavoritesViewmodel extends Cubit<MyFavoritesState> {
  MyFavoritesViewmodel(this.homeViewmodel, this.sharedPreferencesService)
      : super(InitialState());

  final HomeViewmodel homeViewmodel;
  final SharedPreferencesService sharedPreferencesService;

  late List<Restaurant> restaurants;
  Favorites fav = Favorites(ids: ['']);
  RestaurantQueryResult favoriteRestaurants =
      // ignore: prefer_const_constructors
      RestaurantQueryResult(restaurants: []);

  Future<void> fetchFavoriteRestaurants() async {
    try {
      emit(LoadingState());
      restaurants = homeViewmodel.restaurants.restaurants!;

      fav = Favorites.fromJson(
        await sharedPreferencesService.get(
          SharedPreferencesKeys.favoriteRestaurants,
        ),
      );
      for (Restaurant restaurant in restaurants!) {
        if (fav.ids.contains(restaurant.id)) {
          favoriteRestaurants.restaurants!.add(restaurant);
        }
      }
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState('something went wrong'));
    }
  }
}
