import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToHoursEntity on Hours {
  HoursEntity toEntity() => HoursEntity(
        isOpenNow: isOpenNow,
      );
}
