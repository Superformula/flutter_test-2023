part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class CheckFavoriteEvent extends RestaurantEvent {
  const CheckFavoriteEvent({required this.restaurant});

  final Restaurant restaurant;

  @override
  List<Object> get props => [restaurant];
}

class AddFavoriteEvent extends RestaurantEvent {
  const AddFavoriteEvent({required this.restaurantId});

  final String restaurantId;

  @override
  List<Object> get props => [restaurantId];
}

class RemoveFavoriteEvent extends RestaurantEvent {
  const RemoveFavoriteEvent({required this.restaurantId});

  final String restaurantId;

  @override
  List<Object> get props => [restaurantId];
}

class UpdateListEvent extends RestaurantEvent {
  const UpdateListEvent();


  @override
  List<Object> get props => [];
}
