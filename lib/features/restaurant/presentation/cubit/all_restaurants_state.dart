part of 'all_restaurants_cubit.dart';

abstract class AllRestaurantsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllRestaurantsInitial extends AllRestaurantsState {}

class AllRestaurantsLoading extends AllRestaurantsState {}

class AllRestaurantsLoaded extends AllRestaurantsState {
  AllRestaurantsLoaded({
    required this.restaurants,
  });

  final List<RestaurantEntity> restaurants;

  @override
  List<Object> get props => [
    restaurants,
  ];
}

class AllRestaurantsError extends AllRestaurantsState {
  AllRestaurantsError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
    errorMessage,
  ];
}