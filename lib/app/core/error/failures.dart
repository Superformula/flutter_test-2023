import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  toString() => message;

  @override
  List get props => [];
}

class RestaurantListFailure extends Failure {
  const RestaurantListFailure(super.message);
}

class RestaurantDetailsFailure extends Failure {
  const RestaurantDetailsFailure(super.message);
}

class FavoriteRestaurantsFailure extends Failure {
  const FavoriteRestaurantsFailure(super.message);
}
