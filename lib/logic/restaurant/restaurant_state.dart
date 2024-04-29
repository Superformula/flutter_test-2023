part of 'restaurant_bloc.dart';

@freezed
sealed class RestaurantState with _$RestaurantState {
  const factory RestaurantState.initial() = _Initial;
  const factory RestaurantState.loading() = _Loading;
  const factory RestaurantState.success({required List<Restaurant> restaurants}) = _Success;
  const factory RestaurantState.error({required String message}) = _Error;
}
