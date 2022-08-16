part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsState {
  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) => false;
}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final RestaurantResult restaurantResult;
  RestaurantsLoaded(this.restaurantResult);
}

class RestaurantsError extends RestaurantsState {}
