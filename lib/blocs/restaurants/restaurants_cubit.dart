import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/constants.dart';
import 'package:restaurantour/data/data.dart';
import 'package:restaurantour/data/failures/restaurant_failure.dart';

part 'restaurants_cubit.freezed.dart';
part 'restaurants_state.dart';

@injectable
class RestaurantsCubit extends Cubit<RestaurantsState> {
  final YelpRepository _yelpRepository;

  RestaurantsCubit(this._yelpRepository) : super(RestaurantsState.initial());

  Future<void> getRestaurants() async {
    emit(state.copyWith(isLoading: true, failure: none()));

    final response = await _yelpRepository.getRestaurants(
      offset: state.offset,
      limit: Constants.restaurantsToFetch,
    );

    emit(
      response.fold(
        (f) => state.copyWith(failure: optionOf(f), isLoading: false),
        (result) {
          final length = result.restaurants.length;

          return state.copyWith(
            restaurants: [...state.restaurants, ...result.restaurants],
            hasMore: length == Constants.restaurantsToFetch,
            offset: state.offset + length,
            isLoading: false,
          );
        },
      ),
    );
  }
}
