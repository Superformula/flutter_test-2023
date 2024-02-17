part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Restaurant> favoritesRestaurants;

  FavoritesLoaded({required this.favoritesRestaurants});
}

class FavoritesNotLoaded extends FavoritesState {
  final String? error;

  FavoritesNotLoaded({this.error});
}
