import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/usercases/get_current_restaurants.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final GetCurrentRestaurants _getCurrentRestaurants;

  RestaurantsBloc(this._getCurrentRestaurants) : super(RestaurantsEmpty()) {
    on<FetchRestaurants>(_onFetchRestaurants);
  }

  Future<void> _onFetchRestaurants(event, emit) async {
    emit(RestaurantsLoading());

    final result = await _getCurrentRestaurants.call();
    if (result != null) {
      emit(RestaurantsLoaded([...result.restaurants!]));
    } else {
      emit(const RestaurantsError("Failed to fetch restaurants"));
    }
  }
}
