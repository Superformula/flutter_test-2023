import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Details/viewmodel/detail_state.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_keys.dart';
import 'package:restaurantour/adapter/shared_preferences/shared_preferences_service.dart';
import 'package:restaurantour/models/favorites.dart';
import 'package:restaurantour/models/restaurant.dart';

class DetailViewmodel extends Cubit<DetailState> {
  DetailViewmodel({
    required this.restaurant,
    required this.favoriteRestaurants,
    required this.sharedPreferencesService,
  }) : super(InitialState());

  final Restaurant restaurant;
  RestaurantQueryResult favoriteRestaurants;
  final SharedPreferencesService sharedPreferencesService;
  Favorites fav = Favorites(ids: ['']);

  invertFavoriteValue() {
    emit(LoadingState());
    restaurant.isFavorite = !restaurant.isFavorite;
    emit(LoadedState());
  }

  Future<void> addtoFavorites() async {
    try {
      emit(LoadingState());
      fav = Favorites.fromJson(
        await sharedPreferencesService
            .get(SharedPreferencesKeys.favoriteRestaurants),
      );
      if (fav.ids.contains(restaurant.id)) {
        fav.ids.remove(restaurant.id);
      } else {
        fav.ids.add(restaurant.id!);
      }
      await sharedPreferencesService.set(
        SharedPreferencesKeys.favoriteRestaurants,
        Favorites.toJson(fav),
      );
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState('something went wrong'));
    }
  }
}
