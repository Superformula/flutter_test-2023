import '../../models/restaurant.dart';

abstract class MyFavoritesState {
  const MyFavoritesState();
}

class MyFavoritesLoading extends MyFavoritesState {
  const MyFavoritesLoading();
}

class MyFavoritesLoaded extends MyFavoritesState {
  const MyFavoritesLoaded(this.restaurants);

  final List<Restaurant> restaurants;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyFavoritesLoaded &&
          runtimeType == other.runtimeType &&
          restaurants == other.restaurants;

  @override
  int get hashCode => restaurants.hashCode;
}

class MyFavoritesFetchError extends MyFavoritesState {}
