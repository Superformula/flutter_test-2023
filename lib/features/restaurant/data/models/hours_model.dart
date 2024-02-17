import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/hours_entity.dart';

part 'hours_model.g.dart';

@JsonSerializable()
class HoursModel {
  const HoursModel(
    this.isOpenNow,
  );

  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  factory HoursModel.fromJson(Map<String, dynamic> json) =>
      _$HoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoursModelToJson(this);

  HoursEntity toEntity() {
    return HoursEntity(
      isOpenNow: isOpenNow,
    );
  }
}
