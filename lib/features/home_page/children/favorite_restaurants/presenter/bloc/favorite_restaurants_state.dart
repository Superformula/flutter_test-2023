part of 'favorite_restaurants_bloc.dart';

abstract class FavoriteRestaurantsState extends Equatable {
  const FavoriteRestaurantsState();
}

class FavoriteRestaurantsInitial extends FavoriteRestaurantsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends FavoriteRestaurantsState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class FavoriteRestaurantsLoaded extends FavoriteRestaurantsState {
  const FavoriteRestaurantsLoaded({required this.favoriteList});

  final List<RestaurantModel> favoriteList;

  @override
  List<Object> get props => [favoriteList];
}

class NoFavoritesState extends FavoriteRestaurantsState {
  const NoFavoritesState();

  @override
  List<Object> get props => [];
}

class FavErrorState extends FavoriteRestaurantsState {
  const FavErrorState();

  @override
  List<Object> get props => [];
}