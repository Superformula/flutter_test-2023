part of 'restaurant_detail_cubit.dart';

enum RestaurantDetailStatus {
  initial,
  loaded,
  error,
}

class RestaurantDetailState extends Equatable {
  const RestaurantDetailState({
    required this.restaurantId,
    this.isFavorite = false,
    this.status = RestaurantDetailStatus.initial,
    this.restaurant = Restaurant.empty,
  });
  final String restaurantId;
  final Restaurant restaurant;
  final bool isFavorite;
  final RestaurantDetailStatus status;
  @override
  List<Object> get props => [restaurant, isFavorite, status, restaurantId];
  RestaurantDetailState copyWith({
    Restaurant? restaurant,
    bool? isFavorite,
    RestaurantDetailStatus? status,
    String? restaurantId,
  }) {
    return RestaurantDetailState(
      restaurant: restaurant ?? this.restaurant,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}
