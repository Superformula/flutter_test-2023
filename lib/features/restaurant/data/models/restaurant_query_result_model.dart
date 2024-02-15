import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/data/models/restaurant_model.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_query_result_entity.dart';

part 'restaurant_query_result_model.g.dart';

@JsonSerializable()
class RestaurantQueryResultModel extends RestaurantQueryResultEntity {
  const RestaurantQueryResultModel({
    int? total,
    List<RestaurantModel>? restaurants,
  }) : super(
    total: total,
    restaurants: restaurants,
  );

  factory RestaurantQueryResultModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultModelToJson(this);
}
