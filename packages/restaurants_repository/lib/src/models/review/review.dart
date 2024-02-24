import 'package:json_annotation/json_annotation.dart';
import 'package:restaurants_repository/src/models/models.dart';

part 'review.g.dart';

/// {@template review}
/// Review model
/// {@endtemplate}
@JsonSerializable()
class Review {
  /// {@macro review}
  const Review({
    this.id = '',
    this.rating = 0,
    this.user,
    this.text = '',
  });

  /// [Review.fromJson] that returns an instance of [Review]
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [Review]
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  /// Id of the review.
  final String id;

  /// Rating of the review.
  final int rating;

  /// User of the review.
  final User? user;

  /// Text of the review.
  final String text;
}
