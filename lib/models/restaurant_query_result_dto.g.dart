// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_query_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantQueryResultDto _$RestaurantQueryResultDtoFromJson(
        Map<String, dynamic> json) =>
    RestaurantQueryResultDto(
      total: json['total'] as int?,
      restaurants: (json['business'] as List<dynamic>?)
          ?.map((e) => RestaurantDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantQueryResultDtoToJson(
        RestaurantQueryResultDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'business': instance.restaurants,
    };
