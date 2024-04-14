import 'package:equatable/equatable.dart';

abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();

  @override
  List<Object?> get props => [];
}

class FetchRestaurants extends RestaurantsEvent {
  const FetchRestaurants(
    this.city,
  );
  final String city;

  @override
  List<Object?> get props => [city];
}

class ToggleFavorite extends RestaurantsEvent {
  const ToggleFavorite(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
