import 'package:json_annotation/json_annotation.dart';

part 'hours_entity.g.dart';

@JsonSerializable()
class HoursEntity {
  const HoursEntity({
    this.isOpenNow = false,
  });

  factory HoursEntity.fromJson(Map<String, dynamic> json) =>
      _$HoursEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HoursEntityToJson(this);

  final bool isOpenNow;
}
