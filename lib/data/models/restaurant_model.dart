import 'dart:convert';

import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required String name,
    required String price,
    required double rating,
    required List<String> photos,
    required List<ReviewEntity> review,
  }) : super(
          name: name,
          price: price,
          rating: rating,
          photos: photos,
          review: review,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        name: json['name'],
        price: json['price'],
        rating: json['rating'],
        photos: json['photos'],
        review: jsonDecode(json['review']).map(
          (data) => ReviewModel.fromJson(data),
        ),
      );
}
