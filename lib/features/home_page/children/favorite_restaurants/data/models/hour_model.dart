import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/hour_entity.dart';

class HourModel {
  const HourModel(this.hourEntity);

  final HourEntity hourEntity;

  Map<String, dynamic> toJson() {
    var (isOpenNow) = hourEntity;
    return {
      'is_open_now': isOpenNow,
    };
  }

  factory HourModel.fromJson(Map<String, dynamic> json) {
    return HourModel(
      (json['is_open_now'] as bool? ?? false,),
    );
  }
}
