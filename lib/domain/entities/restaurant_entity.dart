import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.photos,
    required this.review,
    required this.categories,
    required this.isOpenNow,
  });

  final String id;
  final String name;
  final String price;
  final double rating;
  final List<String> photos;
  final List<ReviewEntity> review;
  final bool? isOpenNow;
  final List<CategoryEntity> categories;


  @override
  List<Object?> get props => [
        name,
        price,
        rating,
        photos,
        review,
      ];
}
