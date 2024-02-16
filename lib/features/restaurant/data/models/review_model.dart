import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/user_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends ReviewEntity {
  const ReviewModel({
    String? id,
    int? rating,
    String? text,
    UserModel? user,
  }) : super(
          id: id,
          rating: rating,
          text: text,
          user: user,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
