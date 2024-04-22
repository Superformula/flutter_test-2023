import 'package:json_annotation/json_annotation.dart';
import 'package:yelp_repository/src/models/category.dart';
import 'package:yelp_repository/src/models/hours.dart';
import 'package:yelp_repository/src/models/location.dart';
import 'package:domain_models/domain_models.dart' as domain;

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<Category>? categories;
  final List<Hours>? hours;
  final Location? location;

  const Restaurant({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.categories,
    this.hours,
    this.location,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Use the first category for the category shown to the user
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title ?? '';
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
      return hours!.first.isOpenNow ?? false;
    }
    return false;
  }

  domain.Restaurant toDomain() => domain.Restaurant(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photoUrl: heroImage,
        category: displayCategory,
        isOpen: isOpen,
        address: location?.formattedAddress,
      );
}
