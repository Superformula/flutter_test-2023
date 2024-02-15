import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
abstract class LocationEntity extends Equatable {
  const LocationEntity({
    this.formattedAddress,
  });

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  @override
  List<Object?> get props => [
        formattedAddress,
      ];
}
