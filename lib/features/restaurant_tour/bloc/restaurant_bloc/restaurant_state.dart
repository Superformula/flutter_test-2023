part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant>? restaurants;

  RestaurantLoaded({this.restaurants});
}

class RestaurantNotLoaded extends RestaurantState {
  final String? error;

  RestaurantNotLoaded({this.error});
}
