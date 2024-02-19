import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class FavouriteRestaurantsState extends Equatable{
  const FavouriteRestaurantsState();

  @override
  List<Object?> get props=> [];
}

class FavouriteRestaurantsEmpty extends FavouriteRestaurantsState {}

class FavouriteRestaurantsLoading extends FavouriteRestaurantsState{}

class FavouriteRestaurantsLoaded extends FavouriteRestaurantsState {
  final List<RestaurantEntity> result;
  const FavouriteRestaurantsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}


class FavouriteRestaurantsLoadFail extends FavouriteRestaurantsState {
  final String message;
  const FavouriteRestaurantsLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}