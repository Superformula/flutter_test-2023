import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';

class FavoriteRestaurantsListState extends Equatable {
  final List<RestaurantEntity>? restaurantsList;
  final StatusEnum status;
  const FavoriteRestaurantsListState({
    this.restaurantsList,
    this.status = StatusEnum.initial,
  });

  @override
  List<Object?> get props => [status, restaurantsList];

  FavoriteRestaurantsListState copyWith({
    List<RestaurantEntity>? restaurantsList,
    StatusEnum? status,
  }) {
    return FavoriteRestaurantsListState(
      restaurantsList: restaurantsList ?? this.restaurantsList,
      status: status ?? this.status,
    );
  }
}
