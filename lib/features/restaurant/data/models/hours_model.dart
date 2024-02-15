import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/hours_entity.dart';

part 'hours_model.g.dart';

@JsonSerializable()
class HoursModel extends HoursEntity {
  const HoursModel({
    bool? isOpenNow,
  }) : super(
    isOpenNow: isOpenNow,
  );

  factory HoursModel.fromJson(Map<String, dynamic> json) =>
      _$HoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoursModelToJson(this);
}
