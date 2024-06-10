import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_restaurants_use_case.dart';

part 'restaurant_list_state.dart';

class RestaurantListCubit extends Cubit<RestaurantListState> {
  RestaurantListCubit() : super(RestaurantListLoading());

  final getRestaurantsUseCase = GetIt.instance<GetRestaurantsUseCase>();

  void fetchRestaurants() async {
    emit(RestaurantListLoading());
    try {
      final restaurants = await getRestaurantsUseCase.call(0);
      emit(RestaurantListLoaded(restaurants));
    } catch (e) {
      emit(RestaurantListError(e.toString()));
    }
  }
}
