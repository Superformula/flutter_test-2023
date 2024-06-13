import 'package:flutter/foundation.dart';

import '../../../models/restaurant.dart';

enum RestaurantsStatus { initial, loading, success, failure }

extension RestaurantsStatusX on RestaurantsStatus {
  bool get isInitial => this == RestaurantsStatus.initial;
  bool get isLoading => this == RestaurantsStatus.loading;
  bool get isSuccess => this == RestaurantsStatus.success;
  bool get isFailure => this == RestaurantsStatus.failure;
}

class RestaurantsState {
  RestaurantsState({
    this.status = RestaurantsStatus.initial,
    this.restaurants = const [],
    this.errorMessage = '',
  });

  final RestaurantsStatus status;
  final List<Restaurant> restaurants;
  final String errorMessage;

  @override
  bool operator ==(covariant RestaurantsState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.restaurants, restaurants) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ restaurants.hashCode ^ errorMessage.hashCode;

  RestaurantsState copyWith({
    RestaurantsStatus? status,
    List<Restaurant>? restaurants,
    String? errorMessage,
  }) {
    return RestaurantsState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
