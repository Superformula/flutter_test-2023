part of 'restaurants_cubit.dart';

@freezed
class RestaurantsState with _$RestaurantsState {
  const factory RestaurantsState.loading() = Loading;
  const factory RestaurantsState.data({
    required List<Restaurant> restaurants,
    required bool hasMore,
  }) = Data;
  const factory RestaurantsState.error(RestaurantFailure failure) = Error;
}
