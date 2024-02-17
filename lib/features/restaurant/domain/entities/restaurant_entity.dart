import 'package:equatable/equatable.dart';
import 'package:restaurantour/features/restaurant/domain/entities/category_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/hours_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/location_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.categories,
    this.hours,
    this.reviews,
    this.location,
  });

  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<CategoryEntity>? categories;
  final List<HoursEntity>? hours;
  final List<ReviewEntity>? reviews;
  final LocationEntity? location;

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

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        rating,
        photos,
        categories,
        hours,
        reviews,
        location,
      ];
}
