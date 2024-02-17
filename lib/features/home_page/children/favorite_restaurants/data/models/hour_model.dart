import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/hour_entity.dart';

class HourModel extends HourEntity {
  const HourModel({
    required bool isOpenNow,
  }) : super(
          isOpenNow: isOpenNow,
        );

  Map<String, dynamic> toJson() {
    return {
      'is_open_now': isOpenNow,
    };
  }

  factory HourModel.fromJson(Map<String, dynamic> json) {
    return HourModel(
      isOpenNow: json['is_open_now'] as bool,
    );
  }
}
