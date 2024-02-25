import 'package:json_annotation/json_annotation.dart';
import 'package:restaurants_repository/src/models/models.dart';

part 'restaurant_query_result.g.dart';

/// {@template restaurant_query_result}
/// RestaurantQueryResult model
/// {@endtemplate}
@JsonSerializable()
class RestaurantQueryResult {
  /// {@macro restaurant_query_result}
  const RestaurantQueryResult({
    this.total,
    this.restaurants,
  });

  /// [RestaurantQueryResult.fromJson] that returns an instance of
  /// [RestaurantQueryResult]
  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from
  /// [RestaurantQueryResult]
  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);

  /// Total of the restaurant query result.
  final int? total;

  /// List of restaurants of the restaurant query result.
  @JsonKey(name: 'business')
  final List<Restaurant>? restaurants;
}
