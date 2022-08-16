part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsEvent {}

class FetchRestaurants extends RestaurantsEvent {
  final int offset;
  FetchRestaurants(this.offset);
}

class ToggleFavoriteRestaurant extends RestaurantsEvent {
  final Restaurant restaurant;
  ToggleFavoriteRestaurant(this.restaurant);
}
