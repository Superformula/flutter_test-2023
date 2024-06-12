import 'package:equatable/equatable.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

abstract class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object> get props => [];
}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailLoaded extends RestaurantDetailState {
  const RestaurantDetailLoaded({
    required this.isFavorited,
    required this.restaurant,
  });
  final bool isFavorited;
  final Restaurant restaurant;

  @override
  List<Object> get props => [isFavorited, restaurant];

  RestaurantDetailLoaded copyWith({
    bool? isFavorited,
    Restaurant? restaurant,
  }) {
    return RestaurantDetailLoaded(
      isFavorited: isFavorited ?? this.isFavorited,
      restaurant: restaurant ?? this.restaurant,
    );
  }
}
