import 'package:bloc/bloc.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/favourite_restaurants_bloc/restaurants_state.dart';

class FavouriteRestaurantsBloc extends Bloc<FavouriteRestaurantsEvent, FavouriteRestaurantsState> {
  FavouriteRestaurantsBloc() : super(FavouriteRestaurantsEmpty()) {
 
    on<OnAddToFavorite>((event, emit) {
      emit(FavouriteRestaurantsLoading());
      emit(FavouriteRestaurantsLoaded(event.restaurants));
    });
  }
}
