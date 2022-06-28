import 'package:bloc/bloc.dart';
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

  int offset = 0;

  RestaurantsCubit(this._yelpRepository)
      : super(const RestaurantsState.loading());

  Future<void> getRestaurants() async {
    final response = await _yelpRepository.getRestaurants(
      offset: offset,
      limit: Constants.restaurantsToFetch,
    );

    emit(
      response.fold((f) => RestaurantsState.error(f), (result) {
        offset = offset + result.total;

        return RestaurantsState.data(
          restaurants: result.restaurants,
          hasMore: result.total == Constants.restaurantsToFetch,
        );
      }),
    );
  }
}
