import 'package:json_annotation/json_annotation.dart';
import 'package:yelp_repository/src/models/restaurant.dart';
import 'package:domain_models/domain_models.dart' as domain;

part 'restaurant_query_result.g.dart';

@JsonSerializable()
class RestaurantQueryResult {
  final int? total;
  @JsonKey(name: 'business')
  final List<Restaurant>? restaurants;

  const RestaurantQueryResult({
    this.total,
    this.restaurants,
  });

  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);

  List<domain.Restaurant> get domainRestaurants =>
      restaurants?.map((e) => e.toDomain()).toList() ?? [];
}
