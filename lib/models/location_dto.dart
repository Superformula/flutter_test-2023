import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  LocationDto({this.formattedAddress});

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);
  factory LocationDto.fixture() => LocationDto(formattedAddress: 'address');

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
