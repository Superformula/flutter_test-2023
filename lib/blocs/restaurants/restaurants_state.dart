part of 'restaurants_cubit.dart';

@freezed
class RestaurantsState with _$RestaurantsState {
  const factory RestaurantsState({
    required bool isLoading,
    required Option<RestaurantFailure> failure,
    required List<Restaurant> restaurants,
    required bool hasMore,
    required int offset,
  }) = _RestaurantsState;

  factory RestaurantsState.initial() {
    return _RestaurantsState(
      isLoading: true,
      failure: none(),
      restaurants: [],
      hasMore: true,
      offset: 0,
    );
  }
}
