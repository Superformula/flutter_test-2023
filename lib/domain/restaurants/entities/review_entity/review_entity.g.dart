// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewEntity _$ReviewEntityFromJson(Map<String, dynamic> json) => ReviewEntity(
      id: json['id'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$ReviewEntityToJson(ReviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'user': instance.user,
      'text': instance.text,
    };
