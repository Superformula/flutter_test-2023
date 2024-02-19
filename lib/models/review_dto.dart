import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/models/user_dto.dart';

part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDto {
  final String? id;
  final int? rating;
  final String? text;
  final UserDto? user;

  const ReviewDto({this.text, this.id, this.rating, this.user});

  factory ReviewDto.fromJson(Map<String, dynamic> json) => _$ReviewDtoFromJson(json);
  factory ReviewDto.fixture() => ReviewDto(
        id: 'reviewId',
        rating: 3,
        text: 'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.',
        user: UserDto.fixture(),
      );

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);
}
