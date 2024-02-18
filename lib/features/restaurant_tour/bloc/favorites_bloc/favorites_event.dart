part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class LoadFavoritesEvent extends FavoritesEvent {}

class SaveFavoriteRestaurantEvent extends FavoritesEvent {
  final Restaurant restaurant;

  SaveFavoriteRestaurantEvent(this.restaurant);
}

class RemoveFavoriteRestaurantEvent extends FavoritesEvent {
  final Restaurant restaurant;

  RemoveFavoriteRestaurantEvent(this.restaurant);
}
