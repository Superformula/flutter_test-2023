import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/domain/restaurants/entities/entities.dart';

part 'restaurant_entity.g.dart';

@JsonSerializable()
class RestaurantEntity {
  const RestaurantEntity({
    this.id = '',
    this.name = '',
    this.price = '',
    this.rating = 0,
    this.photos,
    this.categories,
    this.hours,
    this.reviews,
    this.location,
  });

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) =>
      _$RestaurantEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantEntityToJson(this);

  final String id;

  final String name;

  final String price;

  final double rating;

  final List<String>? photos;

  final List<CategoryEntity>? categories;

  final List<HoursEntity>? hours;

  final List<ReviewEntity>? reviews;

  final LocationEntity? location;

  /// Use the first category for the category shown to the user
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title;
    }
    return '';
  }

  /// Use the first image as the image shown to the user
  String get heroImage {
    if (photos != null && photos!.isNotEmpty) {
      return photos!.first;
    }
    return '';
  }

  /// This logic is probably not correct in all cases but it is ok
  /// for this application
  bool get isOpen {
    if (hours != null && hours!.isNotEmpty) {
      return hours!.first.isOpenNow;
    }
    return false;
  }
}
