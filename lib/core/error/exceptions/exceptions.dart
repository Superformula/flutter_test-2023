import 'package:equatable/equatable.dart';

class RestaurantsListException extends Equatable implements Exception {
  final String? message;
  final int statusCode;

  const RestaurantsListException({this.message, this.statusCode = 500});
  @override
  List<Object?> get props => [message, statusCode];
}
