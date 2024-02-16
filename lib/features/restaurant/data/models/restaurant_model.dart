import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/category_model.dart';
import 'package:restaurantour/features/restaurant/data/models/hours_model.dart';
import 'package:restaurantour/features/restaurant/data/models/location_model.dart';
import 'package:restaurantour/features/restaurant/data/models/review_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/category_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/hours_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/location_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    String? id,
    String? name,
    String? price,
    double? rating,
    List<String>? photos,
    List<CategoryEntity>? categories,
    List<HoursEntity>? hours,
    List<ReviewEntity>? reviews,
    LocationEntity? location,
  }) : super(
          id: id,
          name: name,
          price: price,
          rating: rating,
          photos: photos,
          categories: categories,
          hours: hours,
          reviews: reviews,
          location: location,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
