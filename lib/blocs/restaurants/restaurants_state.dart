part of 'restaurants_cubit.dart';

@freezed
class RestaurantsState with _$RestaurantsState {
  const RestaurantsState._();

  const factory RestaurantsState({
    required bool isLoading,
    required bool isLoadingMore,
    required Option<RestaurantFailure> failure,
    required List<RestaurantUi> restaurants,
    required bool hasMore,
    required int offset,
  }) = _RestaurantsState;

  factory RestaurantsState.initial() {
    return _RestaurantsState(
      isLoading: true,
      isLoadingMore: false,
      failure: none(),
      restaurants: [],
      hasMore: true,
      offset: 0,
    );
  }

  List<RestaurantUi> get favorites =>
      restaurants.where((r) => r.isFavorite).toList();
}
