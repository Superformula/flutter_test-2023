import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class RestaurantDetailsState extends Equatable{
  const RestaurantDetailsState();

  @override
  List<Object?> get props=> [];
}

class RestaurantDetailsEmpty extends RestaurantDetailsState {}

class RestaurantDetailsLoading extends RestaurantDetailsState{}

class RestaurantDetailsLoaded extends RestaurantDetailsState {
  final RestaurantDetailsEntity result;
  const RestaurantDetailsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}


class RestaurantDetailsLoadFail extends RestaurantDetailsState {
  final String message;
  const RestaurantDetailsLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}