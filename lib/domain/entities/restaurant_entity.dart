import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    required this.name,
    required this.price,
    required this.rating,
    required this.photos,
    required this.review,
  });

  final String name;
  final String price;
  final double rating;
  final List<String> photos;
  final List<ReviewEntity> review;

  @override
  List<Object?> get props => [
        name,
        price,
        rating,
        photos,
        review,
      ];
}
