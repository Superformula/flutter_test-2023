import 'package:json_annotation/json_annotation.dart';
import 'package:restaurants_repository/src/models/models.dart';

part 'restaurant.g.dart';

/// {@template restaurant}
/// Restaurant model
/// {@endtemplate}
@JsonSerializable()
class Restaurant {
  /// {@macro restaurant}
  const Restaurant({
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

  /// [Restaurant.fromJson] that returns an instance of [Restaurant]
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [Restaurant]
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Id of the restaurant.
  final String id;

  /// Name of the restaurant.
  final String name;

  /// Price of the restaurant.
  final String price;

  /// Rating of the restaurant.
  final double rating;

  /// Photos of the restaurant.
  final List<String>? photos;

  /// List of categories of the restaurant.
  final List<Category>? categories;

  /// List of hours of the restaurant.
  final List<Hours>? hours;

  /// List of reviews of the restaurant.
  final List<Review>? reviews;

  /// Location of the restaurant.
  final Location? location;

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
