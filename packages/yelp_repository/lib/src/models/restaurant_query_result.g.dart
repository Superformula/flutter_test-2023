// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantQueryResult _$RestaurantQueryResultFromJson(
        Map<String, dynamic> json) =>
    RestaurantQueryResult(
      total: json['total'] as int?,
      restaurants: (json['business'] as List<dynamic>?)
          ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantQueryResultToJson(
        RestaurantQueryResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'business': instance.restaurants,
    };
