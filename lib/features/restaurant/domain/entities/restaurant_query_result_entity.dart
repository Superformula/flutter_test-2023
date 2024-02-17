import 'package:equatable/equatable.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';

class RestaurantQueryResultEntity extends Equatable {
  const RestaurantQueryResultEntity({
    this.total,
    this.restaurants,
  });

  final int? total;
  final List<RestaurantEntity>? restaurants;

  @override
  List<Object?> get props => [
        total,
        restaurants,
      ];
}
