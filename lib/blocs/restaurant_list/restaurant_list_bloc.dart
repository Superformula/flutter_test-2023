import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:superformula_flutter_test/services/network_provider.dart';

import '../../models/restaurant.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc extends Bloc<RestaurantListEvent, RestaurantListState> {
  RestaurantListBloc() : super(RestaurantListInitial()) {
    on<FetchRestaurants>((event, emit) async {
      emit(RestaurantListLoading());
      try {
        final RestaurantResult restaurantResult = await NetworkProvider.fetchRestaurants();
        emit(RestaurantListLoaded(restaurantResult));
      } catch (e) {
        print(e);
        emit(RestaurantListError());
      }
    });
  }
}
