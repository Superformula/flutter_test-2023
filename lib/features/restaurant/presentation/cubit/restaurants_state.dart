part of 'restaurants_cubit.dart';

abstract class RestaurantsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  RestaurantsLoaded({
    required this.restaurants,
    required this.favoriteRestaurantsIds,
  });

  final List<RestaurantEntity> restaurants;
  final List<String> favoriteRestaurantsIds;

  @override
  List<Object> get props => [
        restaurants,
        favoriteRestaurantsIds,
      ];
}

class RestaurantsError extends RestaurantsState {
  RestaurantsError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
