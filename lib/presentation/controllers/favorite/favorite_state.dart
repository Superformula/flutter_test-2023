import 'package:flutter/foundation.dart';

import '../../../models/restaurant.dart';

enum FavoriteStatus {
  initial,
  loading,
  success,
  removed,
  favoriteSuccess,
  failure
}

extension FavoriteStatusX on FavoriteStatus {
  bool get isInitial => this == FavoriteStatus.initial;
  bool get isLoading => this == FavoriteStatus.loading;
  bool get isSuccess => this == FavoriteStatus.success;
  bool get isRemoved => this == FavoriteStatus.removed;
  bool get isFavoriteSuccess => this == FavoriteStatus.favoriteSuccess;
  bool get isFailure => this == FavoriteStatus.failure;
}

class FavoriteState {
  FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorites = const [],
    this.errorMessage = '',
  });

  final FavoriteStatus status;
  final List<Restaurant> favorites;
  final String errorMessage;

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<Restaurant>? favorites,
    String? errorMessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant FavoriteState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.favorites, favorites) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ favorites.hashCode ^ errorMessage.hashCode;
}
