import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/hour_entity.dart';

class HourModel {
  final HourEntity hourEntity;

  const HourModel(this.hourEntity);

  Map<String, dynamic> toJson() {
    final isOpenNow = hourEntity.$1;
    return {
      'is_open_now': isOpenNow,
    };
  }

  factory HourModel.fromJson(Map<String, dynamic> json) {
    HourEntity hourEntity = (json['is_open_now'] as bool? ?? false,);
    return HourModel(hourEntity);
  }
}
