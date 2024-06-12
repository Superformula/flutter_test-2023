import 'package:flutter/foundation.dart';

import '../../../models/restaurant.dart';

enum HomeStatus { initial, loading, success, failure }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState {
  HomeState({
    this.status = HomeStatus.initial,
    this.restaurants = const [],
    this.errorMessage = '',
  });

  final HomeStatus status;
  final List<Restaurant> restaurants;
  final String errorMessage;

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.restaurants, restaurants) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ restaurants.hashCode ^ errorMessage.hashCode;

  HomeState copyWith({
    HomeStatus? status,
    List<Restaurant>? restaurants,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
