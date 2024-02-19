// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_query_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewQueryResultDto _$ReviewQueryResultDtoFromJson(
        Map<String, dynamic> json) =>
    ReviewQueryResultDto(
      total: json['total'] as int?,
      review: (json['review'] as List<dynamic>?)
          ?.map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewQueryResultDtoToJson(
        ReviewQueryResultDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'review': instance.review,
    };
