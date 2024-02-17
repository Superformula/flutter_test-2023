part of 'favorite_restaurants_bloc.dart';

abstract class FavoriteRestaurantsEvent extends Equatable {
  const FavoriteRestaurantsEvent();
}

class InitialEvent extends FavoriteRestaurantsEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}