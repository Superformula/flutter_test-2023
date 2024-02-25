import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/domain/restaurants/entities/entities.dart';

part 'review_entity.g.dart';

@JsonSerializable()
class ReviewEntity {
  const ReviewEntity({
    this.id = '',
    this.rating = 0,
    this.user,
    this.text = '',
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewEntityToJson(this);

  final String id;

  final int rating;

  final UserEntity? user;

  final String text;
}
