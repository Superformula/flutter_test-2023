part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListState {
  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) => false;
}

class RestaurantListInitial extends RestaurantListState {}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final RestaurantResult restaurantResult;
  RestaurantListLoaded(this.restaurantResult);
}

class RestaurantListError extends RestaurantListState {}
