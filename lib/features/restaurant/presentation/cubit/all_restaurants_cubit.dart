import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';

part 'all_restaurants_state.dart';

class AllRestaurantsCubit extends Cubit<AllRestaurantsState> {
  AllRestaurantsCubit({
    required GetAllRestaurantsUseCase getAllRestaurantsUseCase,
  })  : _getAllRestaurantsUseCase = getAllRestaurantsUseCase,
        super(AllRestaurantsInitial());

  final GetAllRestaurantsUseCase _getAllRestaurantsUseCase;

  Future<void> loadReminderList() async {
    final result = await _getAllRestaurantsUseCase();

    result.fold(
      (errorMessage) => emit(
        AllRestaurantsError(errorMessage: errorMessage),
      ),
      (restaurants) => emit(
        AllRestaurantsLoaded(restaurants: restaurants),
      ),
    );
  }
}
