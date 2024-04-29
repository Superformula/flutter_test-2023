import 'package:json_annotation/json_annotation.dart';
import 'package:yelp_repository/src/models/user.dart';
import 'package:domain_models/domain_models.dart' as domain;

part 'review.g.dart';

@JsonSerializable()
class Review {
  final String? id;
  final int? rating;
  final String? text;
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.text,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  domain.Review get toDomain => domain.Review(
        id: id ?? '',
        rating: rating ?? 0,
        text: text ?? '',
        user: domain.User(
          imageUrl: user?.imageUrl ?? '',
          name: user?.name ?? '',
        ),
      );
}
