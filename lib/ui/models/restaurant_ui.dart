import 'package:restaurantour/data/data.dart';

class RestaurantUi {
  final bool isFavorite;
  final Restaurant restaurant;

  RestaurantUi({this.isFavorite = false, required this.restaurant});

  RestaurantUi copyWith({required bool isFavorite}) {
    return RestaurantUi(
      isFavorite: isFavorite,
      restaurant: restaurant,
    );
  }
}
