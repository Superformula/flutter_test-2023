import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

part 'all_restaurant_event.dart';

part 'all_restaurant_state.dart';

class AllRestaurantBloc extends Bloc<AllRestaurantEvent, AllRestaurantState> {
  AllRestaurantBloc({required this.hiveHelper, required this.yelpRepository})
      : super(AllRestaurantInitial()) {
    on<IniEvent>(_onInitEvent);
  }

  final HiveHelper hiveHelper;
  final YelpRepository yelpRepository;

  Future<void> _onInitEvent(
    IniEvent event,
    Emitter<AllRestaurantState> emit,
  ) async {
    emit(
      const LoadingState(),
    );
    final yelpRepo = yelpRepository;
    final result = await yelpRepo.getRestaurants();

    result.when(
      ok: (data) {
        if (data.restaurants.isNotEmpty) {
          emit(
            DataLoadedState(
              restaurantList: data.restaurants,
            ),
          );
        } else {
          emit(const EmptyDataState());
        }
      },
      err: (error) {
        emit(
          ErrorState(
            error: error.toString(),
          ),
        );
      },
    );
  }
}
