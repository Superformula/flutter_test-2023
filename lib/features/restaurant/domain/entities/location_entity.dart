import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    this.formattedAddress,
  });

  final String? formattedAddress;

  @override
  List<Object?> get props => [
        formattedAddress,
      ];
}
