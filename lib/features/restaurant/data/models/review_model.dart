import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/user_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  const ReviewModel({
    this.id,
    this.rating,
    this.text,
    this.user,
  });

  final String? id;
  final int? rating;
  final String? text;
  final UserModel? user;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      rating: rating,
      text: text,
      user: user?.toEntity(),
    );
  }
}
