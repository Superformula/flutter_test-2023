// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      alias: json['alias'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'title': instance.title,
    };

HoursEntity _$HoursEntityFromJson(Map<String, dynamic> json) => HoursEntity(
      isOpenNow: json['isOpenNow'] as bool?,
    );

Map<String, dynamic> _$HoursEntityToJson(HoursEntity instance) =>
    <String, dynamic>{
      'isOpenNow': instance.isOpenNow,
    };

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
    };

ReviewEntity _$ReviewEntityFromJson(Map<String, dynamic> json) => ReviewEntity(
      id: json['id'] as String?,
      rating: json['rating'] as int?,
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewEntityToJson(ReviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'user': instance.user,
    };

LocationEntity _$LocationEntityFromJson(Map<String, dynamic> json) =>
    LocationEntity(
      formattedAddress: json['formattedAddress'] as String?,
    );

Map<String, dynamic> _$LocationEntityToJson(LocationEntity instance) =>
    <String, dynamic>{
      'formattedAddress': instance.formattedAddress,
    };

RestaurantEntity _$RestaurantEntityFromJson(Map<String, dynamic> json) =>
    RestaurantEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
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

RestaurantQueryResultEntity _$RestaurantQueryResultEntityFromJson(
        Map<String, dynamic> json) =>
    RestaurantQueryResultEntity(
      total: json['total'] as int?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => RestaurantEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantQueryResultEntityToJson(
        RestaurantQueryResultEntity instance) =>
    <String, dynamic>{
      'total': instance.total,
      'restaurants': instance.restaurants,
    };
