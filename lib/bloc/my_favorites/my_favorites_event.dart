import '../../models/restaurant.dart';

abstract class MyFavoritesEvent {}

class MyFavoritesStarted extends MyFavoritesEvent {}

class AddRestaurantToFavorites extends MyFavoritesEvent {
  Restaurant restaurant;
  AddRestaurantToFavorites(this.restaurant);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddRestaurantToFavorites &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}

class RemoveRestaurantFromFavorites extends MyFavoritesEvent {
  Restaurant restaurant;
  RemoveRestaurantFromFavorites(this.restaurant);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoveRestaurantFromFavorites &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}
