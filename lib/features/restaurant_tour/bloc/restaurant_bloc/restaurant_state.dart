part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant>? restaurants;

  RestaurantLoaded({this.restaurants});
}

class RestaurantNotLoaded extends RestaurantState {
  final String? error;

  RestaurantNotLoaded({this.error});
}
