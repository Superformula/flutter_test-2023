import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/restaurant_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_query_result_entity.dart';

part 'restaurant_query_result_model.g.dart';

@JsonSerializable()
class RestaurantQueryResultModel {
  const RestaurantQueryResultModel({
    this.total,
    this.restaurants,
  });

  final int? total;
  @JsonKey(name: 'business')
  final List<RestaurantModel>? restaurants;

  factory RestaurantQueryResultModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultModelToJson(this);

  RestaurantQueryResultEntity toEntity() {
    return RestaurantQueryResultEntity(
      total: total,
      restaurants:
          restaurants?.map((restaurant) => restaurant.toEntity()).toList(),
    );
  }
}
