import 'package:restaurantour/data/models/review_model.dart';
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
  }) : super(
          id: id,
          name: name,
          price: price,
          rating: rating,
          photos: photos,
          review: review,
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
      );

  RestaurantEntity toEntity() => RestaurantEntity(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photos: photos,
        review: review,
      );
}
