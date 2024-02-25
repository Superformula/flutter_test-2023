import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// {@template location}
/// Location model
/// {@endtemplate}
@JsonSerializable()
class Location {
  /// {@macro location}
  const Location({
    this.formattedAddress = '',
  });

  /// [Location.fromJson] that returns an instance of [Location]
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [Location]
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  /// Formatted address from the location.
  @JsonKey(name: 'formatted_address')
  final String formattedAddress;
}
