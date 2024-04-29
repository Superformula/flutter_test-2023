part of 'restaurant_bloc.dart';

@freezed
sealed class RestaurantEvent with _$RestaurantEvent {
  const factory RestaurantEvent.getRestaurants({@Default(0) int offset}) = _GetRestaurants;
}