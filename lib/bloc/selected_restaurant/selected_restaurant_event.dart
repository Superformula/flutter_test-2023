import '../../models/restaurant.dart';

abstract class SelectedRestaurantEvent {
  const SelectedRestaurantEvent();
}

class SelectRestaurant extends SelectedRestaurantEvent {
  const SelectRestaurant(this.restaurant);

  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}

class DeselectRestaurant extends SelectedRestaurantEvent {
  const DeselectRestaurant();
}
