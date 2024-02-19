import 'package:restaurantour/domain/entities/restaurant_details_entity.dart';

class RestaurantDetailsModel extends RestaurantDetailsEntity {
  const RestaurantDetailsModel({
    required String id,
    required String name,
    required String address,
    required double rating,
    required int reviewCount,
  }) : super(
          id: id,
          name: name,
          address: address,
          rating: rating,
          reviewCount: reviewCount,
        );

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailsModel(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        address: json['location']['address1'],
        reviewCount: json['review_count'],
      );

  RestaurantDetailsEntity toEntity() => RestaurantDetailsEntity(
        id: id,
        name: name,
        address: address,
        rating: rating,
        reviewCount: reviewCount,
      );
}
