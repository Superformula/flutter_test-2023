import 'package:json_annotation/json_annotation.dart';

part 'hours_dto.g.dart';

@JsonSerializable()
class HoursDto {
  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  const HoursDto({this.isOpenNow});

  factory HoursDto.fromJson(Map<String, dynamic> json) => _$HoursDtoFromJson(json);
  factory HoursDto.fixture() => const HoursDto(isOpenNow: true);

  Map<String, dynamic> toJson() => _$HoursDtoToJson(this);
}
