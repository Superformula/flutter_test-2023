import '../../../models/restaurant.dart';

abstract class SelectedRestaurantEvent {
  const SelectedRestaurantEvent();
}

class SelectedRestaurant extends SelectedRestaurantEvent {
  const SelectedRestaurant(this.restaurant);

  final Restaurant restaurant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedRestaurant &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}
