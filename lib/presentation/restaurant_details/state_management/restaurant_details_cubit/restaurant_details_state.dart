part of 'restaurant_details_cubit.dart';

@freezed
class RestaurantDetailsState with _$RestaurantDetailsState {
  const factory RestaurantDetailsState.initial() = _Initial;
  const factory RestaurantDetailsState.loaded({
    required RestaurantEntity restaurant,
  }) = _Loaded;
}
