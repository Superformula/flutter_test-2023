import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/location_entity.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  const LocationModel({
    this.formattedAddress,
  });

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  LocationEntity toEntity() {
    return LocationEntity(
      formattedAddress: formattedAddress,
    );
  }
}
