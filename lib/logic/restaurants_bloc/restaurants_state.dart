part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsState {}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsError extends RestaurantsState {
  RestaurantsError(this.errorMessage);
  final String errorMessage;
}

class RestaurantsData extends RestaurantsState {
  RestaurantsData(this.restaurantsList);
  final List<Restaurant> restaurantsList;
}
