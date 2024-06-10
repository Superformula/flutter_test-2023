part of 'restaurant_list_cubit.dart';

abstract class RestaurantListState extends Equatable {
  const RestaurantListState();

  @override
  List<Object> get props => [];
}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final List<Restaurant> restaurants;

  const RestaurantListLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantListError extends RestaurantListState {
  final String message;

  const RestaurantListError(this.message);

  @override
  List<Object> get props => [message];
}
