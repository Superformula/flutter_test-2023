import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required String id,
    required String name,
    required String price,
    required double rating,
    required List<String> photos,
    required List<ReviewEntity> review,
    required List<CategoryEntity> categories,
    required bool isOpenNow,
  }) : super(
          id: id,
          name: name,
          price: price,
          rating: rating,
          photos: photos,
          review: review,
          categories: categories,
          isOpenNow: isOpenNow,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        rating: json['rating'],
        photos: json['photos'].cast<String>(),
        review: json['reviews']
            .map(
              (data) => ReviewModel.fromJson(data),
            )
            .toList()
            .cast<ReviewModel>(),
        categories: json['categories']
            .map(
              (data) => CategoryModel.fromJson(data),
            )
            .toList()
            .cast<CategoryModel>(),
        isOpenNow: json['hours']?.first['is_open_now'] ?? false,
      );

  RestaurantEntity toEntity() => RestaurantEntity(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photos: photos,
        review: review,
        categories: categories,
        isOpenNow: isOpenNow,
      );
}
