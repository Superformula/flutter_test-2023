import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/category_model.dart';
import 'package:restaurantour/features/restaurant/data/models/hours_model.dart';
import 'package:restaurantour/features/restaurant/data/models/location_model.dart';
import 'package:restaurantour/features/restaurant/data/models/review_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';

part 'restaurant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantModel {
  const RestaurantModel({
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
  final List<CategoryModel>? categories;
  final List<HoursModel>? hours;
  final List<ReviewModel>? reviews;
  final LocationModel? location;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  RestaurantEntity toEntity() {
    return RestaurantEntity(
      id: id,
      name: name,
      price: price,
      rating: rating,
      photos: photos,
      categories: categories?.map((category) => category.toEntity()).toList(),
      hours: hours?.map((hour) => hour.toEntity()).toList(),
      reviews: reviews?.map((review) => review.toEntity()).toList(),
      location: location?.toEntity(),
    );
  }
}
