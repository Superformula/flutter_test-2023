import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

abstract class ReviewState extends Equatable{
  const ReviewState();

  @override
  List<Object?> get props=> [];
}

class ReviewEmpty extends ReviewState {}

class ReviewLoading extends ReviewState{}

class ReviewLoaded extends ReviewState {
  final List<ReviewEntity> result;
  const ReviewLoaded(this.result);

  @override
  List<Object?> get props => [result];
}


class ReviewLoadFail extends ReviewState {
  final String message;
  const ReviewLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}