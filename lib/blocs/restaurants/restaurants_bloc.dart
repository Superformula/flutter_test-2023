import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/services/network_provider.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final List<Restaurant> allRestaurants = [];
  final List<Restaurant> favoriteRestaurants = [];

  RestaurantsBloc(NetworkProvider networkProvider) : super(RestaurantsInitial()) {
    on<FetchRestaurants>((event, emit) async {
      if (event.offset == 0) {
        emit(RestaurantsLoading());
      }
      try {
        final RestaurantResult restaurantResult = await networkProvider.fetchRestaurants(offset: event.offset);
        allRestaurants.addAll(restaurantResult.restaurants);
        restaurantResult.restaurants.clear();
        restaurantResult.restaurants.addAll(allRestaurants);
        emit(RestaurantsLoaded(restaurantResult));
      } catch (e) {
        print(e);
        emit(RestaurantsError());
      }
    });
    on<ToggleFavoriteRestaurant>((event, emit) {
      if (favoriteRestaurants.contains(event.restaurant)) {
        favoriteRestaurants.remove(event.restaurant);
      } else {
        favoriteRestaurants.add(event.restaurant);
      }
      emit(state);
    });
  }
}
