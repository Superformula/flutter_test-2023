import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/error/error.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
