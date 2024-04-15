part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsEvent {}

class LoadRestaurants extends RestaurantsEvent {
  LoadRestaurants({this.offset});
  final int? offset;
}
