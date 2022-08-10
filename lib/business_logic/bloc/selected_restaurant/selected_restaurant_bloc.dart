import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'selected_restaurant_event.dart';
import 'selected_restaurant_state.dart';

class SelectedRestaurantBloc
    extends Bloc<SelectedRestaurantEvent, SelectedRestaurantState> {
  SelectedRestaurantBloc() : super(SelectedRestaurantState.empty) {
    on<SelectedRestaurant>(_selectedRestaurant);
  }

  void _selectedRestaurant(
    SelectedRestaurant event,
    Emitter<SelectedRestaurantState> emit,
  ) {
    emit(SelectedRestaurantState(event.restaurant));
  }
}
