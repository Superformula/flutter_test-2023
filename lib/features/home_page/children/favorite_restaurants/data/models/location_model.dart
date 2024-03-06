import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({required String formattedAddress})
      : super(formattedAddress: formattedAddress);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      formattedAddress: json['formatted_address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formatted_address': formattedAddress,
    };
  }
}
