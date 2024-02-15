part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant>? restaurants;
  final String? error;

  RestaurantLoaded({this.restaurants, this.error});
}

class RestaurantNotLoaded extends RestaurantState {
  final String? error;

  RestaurantNotLoaded({this.error});
}
