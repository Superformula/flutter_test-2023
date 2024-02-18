import 'package:equatable/equatable.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class RestaurantsEvent extends Equatable{
  const RestaurantsEvent();

  @override
  List<Object?> get props=> [];
}

class OnRequestedRestaurants extends RestaurantsEvent{
  final List<RestaurantEntity> restaurantsList;

  const OnRequestedRestaurants(this.restaurantsList);
  
  @override
  List<Object?> get props => [restaurantsList];
}