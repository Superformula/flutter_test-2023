part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

class AppBarLoadingState extends RestaurantState {
  const AppBarLoadingState();

  @override
  List<Object> get props => [];
}

class VerifiedState extends RestaurantState {
  const VerifiedState({required this.isFavorited});

  final bool isFavorited;

  @override
  List<Object> get props => [isFavorited];
}

class ErrorState extends RestaurantState {
  const ErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [];
}

class FavoriteOperationSuccess extends RestaurantState {
  const FavoriteOperationSuccess();

  @override
  List<Object> get props => [];
}

class FavoriteOperationError extends RestaurantState {
  const FavoriteOperationError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
