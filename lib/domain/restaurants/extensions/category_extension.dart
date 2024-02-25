import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToCategoryEntity on Category {
  CategoryEntity toEntity() => CategoryEntity(
        alias: alias,
        title: title,
      );
}
