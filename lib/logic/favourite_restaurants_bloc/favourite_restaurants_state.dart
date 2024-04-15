part of 'favourite_restaurants_bloc.dart';

@immutable
abstract class FavouriteRestaurantsState {}

class FavouriteRestaurantsInitial extends FavouriteRestaurantsState {}

class FavouriteRestaurantsData extends FavouriteRestaurantsState {
  FavouriteRestaurantsData(this.restaurantsList);
  final List<Restaurant> restaurantsList;
}

class FavouriteRestaurantsError extends FavouriteRestaurantsState {
  FavouriteRestaurantsError(this.errorMessage);
  final String errorMessage;
}
