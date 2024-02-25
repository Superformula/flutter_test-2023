// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantEntity _$RestaurantEntityFromJson(Map<String, dynamic> json) =>
    RestaurantEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      hours: (json['hours'] as List<dynamic>?)
          ?.map((e) => HoursEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantEntityToJson(RestaurantEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rating': instance.rating,
      'photos': instance.photos,
      'categories': instance.categories,
      'hours': instance.hours,
      'reviews': instance.reviews,
      'location': instance.location,
    };
