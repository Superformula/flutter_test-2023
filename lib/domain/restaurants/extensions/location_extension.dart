import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToLocationEntity on Location {
  LocationEntity toEntity() => LocationEntity(
        formattedAddress: formattedAddress,
      );
}
