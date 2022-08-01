part of 'restaurant_detail_cubit.dart';

class RestaurantDetailState extends Equatable {
  const RestaurantDetailState({
    required this.restaurant,
    this.isFavorite = false,
  });
  final Restaurant restaurant;
  final bool isFavorite;
  @override
  List<Object> get props => [restaurant, isFavorite];
  RestaurantDetailState copyWith({
    Restaurant? restaurant,
    bool? isFavorite,
  }) {
    return RestaurantDetailState(
      restaurant: restaurant ?? this.restaurant,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
