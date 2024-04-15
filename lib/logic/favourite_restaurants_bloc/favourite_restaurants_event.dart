part of 'favourite_restaurants_bloc.dart';

@immutable
abstract class FavouriteRestaurantsEvent {}

class FavRestaurant extends FavouriteRestaurantsEvent {
  FavRestaurant({required this.restaurant});
  final Restaurant restaurant;
}

class UnfavRestaurant extends FavouriteRestaurantsEvent {
  UnfavRestaurant({required this.restaurantId});
  final String restaurantId;
}

class LoadRestaurantsStatus extends FavouriteRestaurantsEvent {
  LoadRestaurantsStatus();
}
