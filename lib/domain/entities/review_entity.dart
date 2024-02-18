import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/user_entity.dart';

class ReviewEntity extends Equatable {
  const ReviewEntity({
    required this.id,
    required this.rating,
    required this.user,
  });

  final String id;
  final double rating;
  final UserEntity user;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
