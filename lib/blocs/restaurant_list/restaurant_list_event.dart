part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListEvent {}

class FetchRestaurants extends RestaurantListEvent {
  final int offset;
  FetchRestaurants(this.offset);
}
