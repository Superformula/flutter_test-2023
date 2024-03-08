// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    RestaurantDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      hours: (json['hours'] as List<dynamic>?)
          ?.map((e) => HoursDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantDtoToJson(RestaurantDto instance) =>
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
