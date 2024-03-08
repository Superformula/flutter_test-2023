import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/models/category_dto.dart';
import 'package:restaurantour/models/hours_dto.dart';
import 'package:restaurantour/models/location_dto.dart';
import 'package:restaurantour/models/review_dto.dart';

part 'restaurant_dto.g.dart';

@JsonSerializable()
class RestaurantDto {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<CategoryDto>? categories;
  final List<HoursDto>? hours;
  final List<ReviewDto>? reviews;
  final LocationDto? location;

  const RestaurantDto({
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

  factory RestaurantDto.fromJson(Map<String, dynamic> json) => _$RestaurantDtoFromJson(json);
  factory RestaurantDto.fixture() => RestaurantDto(
        id: 'restaurantId',
        name: 'Restaurant Name',
        price: '\$\$',
        rating: 3.5,
        photos: ['http://placeimg.com/640/480/business'],
        categories: [CategoryDto.fixture()],
        hours: [HoursDto.fixture()],
        reviews: [ReviewDto.fixture()],
        location: LocationDto.fixture(),
      );

  Map<String, dynamic> toJson() => _$RestaurantDtoToJson(this);

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
}
