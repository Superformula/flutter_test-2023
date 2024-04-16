import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class RestaurantListFailure extends Failure {
  final String? message;
  const RestaurantListFailure({this.message});
}
