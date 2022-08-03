import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurantour/bloc/selected_restaurant/selected_restaurant_event.dart';
import 'package:restaurantour/bloc/selected_restaurant/selected_restaurant_state.dart';

class SelectedRestaurantBloc
    extends Bloc<SelectedRestaurantEvent, SelectedRestaurantState> {
  SelectedRestaurantBloc() : super(SelectedRestaurantState.empty) {
    on<SelectRestaurant>(_selectRestaurant);
  }

  void _selectRestaurant(
    SelectRestaurant event,
    Emitter<SelectedRestaurantState> emit,
  ) {
    emit(SelectedRestaurantState(event.restaurant));
  }
}