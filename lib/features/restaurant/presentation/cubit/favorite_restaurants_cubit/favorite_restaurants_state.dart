part of 'favorite_restaurants_cubit.dart';

abstract class FavoriteRestaurantsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteRestaurantsInitial extends FavoriteRestaurantsState {}

class FavoriteRestaurantsLoading extends FavoriteRestaurantsState {}

class FavoriteRestaurantsLoaded extends FavoriteRestaurantsState {
  FavoriteRestaurantsLoaded({
    required this.restaurants,
  });

  final List<RestaurantEntity> restaurants;

  @override
  List<Object> get props => [
        restaurants,
      ];
}
