part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListState {}

class RestaurantListInitial extends RestaurantListState {}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final RestaurantResult restaurantResult;
  RestaurantListLoaded(this.restaurantResult);
}

class RestaurantListError extends RestaurantListState {}
