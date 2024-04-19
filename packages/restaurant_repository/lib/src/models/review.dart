import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_repository/src/models/user.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final String? id;
  final int? rating;
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
