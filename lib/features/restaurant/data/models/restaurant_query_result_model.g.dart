// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_query_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantQueryResultModel _$RestaurantQueryResultModelFromJson(
        Map<String, dynamic> json) =>
    RestaurantQueryResultModel(
      total: json['total'] as int?,
      restaurants: (json['business'] as List<dynamic>?)
          ?.map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantQueryResultModelToJson(
        RestaurantQueryResultModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'business': instance.restaurants,
    };
