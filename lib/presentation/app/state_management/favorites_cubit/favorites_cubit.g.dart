// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Loaded _$$_LoadedFromJson(Map<String, dynamic> json) => _$_Loaded(
      restaurants: (json['restaurants'] as List<dynamic>)
          .map((e) => RestaurantEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_LoadedToJson(_$_Loaded instance) => <String, dynamic>{
      'restaurants': instance.restaurants,
    };
