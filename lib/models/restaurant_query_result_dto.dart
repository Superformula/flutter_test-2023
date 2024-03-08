import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/models/restaurant_dto.dart';

part 'restaurant_query_result_dto.g.dart';

@JsonSerializable()
class RestaurantQueryResultDto {
  final int? total;
  @JsonKey(name: 'business')
  final List<RestaurantDto>? restaurants;

  const RestaurantQueryResultDto({this.total, this.restaurants});

  factory RestaurantQueryResultDto.fromJson(Map<String, dynamic> json) => _$RestaurantQueryResultDtoFromJson(json);
  factory RestaurantQueryResultDto.fixture() => RestaurantQueryResultDto(restaurants: [RestaurantDto.fixture()]);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultDtoToJson(this);
}
