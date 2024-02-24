part of 'restaurant_details_cubit.dart';

@freezed
class RestaurantDetailsState with _$RestaurantDetailsState {
  const factory RestaurantDetailsState.initial({
    Restaurant? restaurant,
  }) = _Initial;
}
