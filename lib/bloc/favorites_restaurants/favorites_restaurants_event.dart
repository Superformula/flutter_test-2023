import '../../models/restaurant.dart';

abstract class FavoritesRestaurantsEvent {
  const FavoritesRestaurantsEvent();
}

class AddFavoriteRestaurant extends FavoritesRestaurantsEvent {
  const AddFavoriteRestaurant(this.restaurant);
  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddFavoriteRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}

class RemoveFavoriteRestaurant extends FavoritesRestaurantsEvent {
  const RemoveFavoriteRestaurant(this.restaurant);
  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoveFavoriteRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}
