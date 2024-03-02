import 'package:restaurantour/domain/restaurants/entities/review_entity.dart';

class RestaurantEntity {
  final String id;
  final String name;
  final String heroImage;
  final String price;
  final double rating;
  final bool isOpen;
  final List<ReviewEntity> reviews;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.heroImage,
    required this.price,
    required this.rating,
    required this.isOpen,
    required this.reviews,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantEntity &&
        other.id == id &&
        other.name == name &&
        other.heroImage == heroImage &&
        other.price == price &&
        other.rating == rating &&
        other.isOpen == isOpen &&
        other.reviews == reviews;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        heroImage.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        isOpen.hashCode ^
        reviews.hashCode;
  }
}
