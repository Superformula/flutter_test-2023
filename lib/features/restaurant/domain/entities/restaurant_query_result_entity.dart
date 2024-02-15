import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';

@JsonSerializable(explicitToJson: true)
abstract class RestaurantQueryResultEntity extends Equatable {
  const RestaurantQueryResultEntity({
    this.total,
    this.restaurants,
  });

  final int? total;
  @JsonKey(name: 'business')
  final List<RestaurantEntity>? restaurants;

  @override
  List<Object?> get props => [
    total,
    restaurants,
  ];
}
