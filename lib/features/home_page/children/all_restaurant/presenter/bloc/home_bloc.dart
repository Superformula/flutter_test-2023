import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.hiveHelper, required this.yelpRepository})
      : super(HomeInitial()) {
    on<InitialEvent>(_onInitialEvent);
  }

  final HiveHelper hiveHelper;
  final YelpRepository yelpRepository;

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    final yelpRepo = yelpRepository;
    final result = await yelpRepo.getRestaurants();
    emit(
      const HomeLoadingState(),
    );

    result.when(
      ok: (data) {
        if (data.restaurants.isNotEmpty) {
          List<String> favoriteIds = hiveHelper.getAllFavoriteIds();
          List<Restaurant> favoriteList = data.restaurants
              .where((restaurant) => favoriteIds.contains(restaurant.id))
              .toList();

          emit(
            HomeDataLoadedState(
              restaurantList: data.restaurants,
              favoriteList: favoriteList,
            ),
          );
        } else {
          emit(const HomeEmptyDataState());
        }
      },
      err: (error) {
        emit(
          HomeErrorState(
            error: error.toString(),
          ),
        );
      },
    );
  }
}
