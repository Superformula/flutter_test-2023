import 'package:equatable/equatable.dart';

sealed class RestaurantListEvent extends Equatable {
  const RestaurantListEvent();
}

class GetRestaurantsListEvent extends RestaurantListEvent {
  @override
  List<Object> get props => [];
}
