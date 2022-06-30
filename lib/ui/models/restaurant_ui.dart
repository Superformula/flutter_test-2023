import 'package:equatable/equatable.dart';
import 'package:restaurantour/data/data.dart';

class RestaurantUi extends Equatable {
  final bool isFavorite;
  final Restaurant restaurant;

  const RestaurantUi({this.isFavorite = false, required this.restaurant});

  RestaurantUi copyWith({required bool isFavorite}) {
    return RestaurantUi(isFavorite: isFavorite, restaurant: restaurant);
  }

  @override
  List<Object?> get props => [isFavorite, restaurant];
}
