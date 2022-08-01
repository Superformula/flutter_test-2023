import 'package:collection/collection.dart';

import '../models/restaurant.dart';

abstract class RestaurantsState {
  const RestaurantsState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantsState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded(this.restaurants);

  final List<Restaurant>? restaurants;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RestaurantsLoaded &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(restaurants, other.restaurants);

  @override
  int get hashCode => super.hashCode ^ restaurants.hashCode;
}

class RestaurantsFetchError extends RestaurantsState {}
