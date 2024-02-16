import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/user_entity.dart';

@JsonSerializable(explicitToJson: true)
abstract class ReviewEntity extends Equatable {
  const ReviewEntity({
    this.id,
    this.rating,
    this.text,
    this.user,
  });

  final String? id;
  final int? rating;
  final String? text;
  final UserEntity? user;

  @override
  List<Object?> get props => [
        id,
        rating,
        text,
        user,
      ];
}
