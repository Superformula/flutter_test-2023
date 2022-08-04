import '../../../models/restaurant.dart';

abstract class FavoritesRestaurantsEvent {
  const FavoritesRestaurantsEvent();
}

class AddedFavoriteRestaurant extends FavoritesRestaurantsEvent {
  const AddedFavoriteRestaurant(this.restaurant);

  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddedFavoriteRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}

class RemovedFavoriteRestaurant extends FavoritesRestaurantsEvent {
  const RemovedFavoriteRestaurant(this.restaurant);

  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemovedFavoriteRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}
