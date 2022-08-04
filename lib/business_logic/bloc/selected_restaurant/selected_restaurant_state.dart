import '../../../models/restaurant.dart';

class SelectedRestaurantState {
  const SelectedRestaurantState([this.restaurant]);

  final Restaurant? restaurant;

  static const empty = SelectedRestaurantState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedRestaurantState &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant;

  @override
  int get hashCode => restaurant.hashCode;
}
