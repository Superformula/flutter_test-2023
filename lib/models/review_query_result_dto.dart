import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/models/review_dto.dart';

part 'review_query_result_dto.g.dart';

@JsonSerializable()
class ReviewQueryResultDto {
  final int? total;
  @JsonKey(name: 'review')
  final List<ReviewDto>? review;

  const ReviewQueryResultDto({this.total, this.review});

  factory ReviewQueryResultDto.fromJson(Map<String, dynamic> json) => _$ReviewQueryResultDtoFromJson(json);
  factory ReviewQueryResultDto.fixture() => ReviewQueryResultDto(total: 1, review: [ReviewDto.fixture()]);

  Map<String, dynamic> toJson() => _$ReviewQueryResultDtoToJson(this);
}
