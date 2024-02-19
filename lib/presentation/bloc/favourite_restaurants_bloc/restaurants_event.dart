import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

abstract class FavouriteRestaurantsEvent extends Equatable{
  const FavouriteRestaurantsEvent();

  @override
  List<Object?> get props=> [];
}


class OnAddToFavorite extends FavouriteRestaurantsEvent {
  final List<RestaurantEntity> restaurants;
  const OnAddToFavorite(this.restaurants);

  @override
  List<Object?> get props => [];
}