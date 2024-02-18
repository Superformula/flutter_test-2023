import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class RestaurantsState extends Equatable{
  const RestaurantsState();

  @override
  List<Object?> get props=> [];
}

class RestaurantsEmpty extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState{}

class RestaurantsLoaded extends RestaurantsState {
  final List<RestaurantEntity> result;
  const RestaurantsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class RestaurantsLoadFail extends RestaurantsState {
  final String message;
  const RestaurantsLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}