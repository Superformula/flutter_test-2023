import 'package:json_annotation/json_annotation.dart';

part 'hours.g.dart';

/// {@template hours}
/// Hours model
/// {@endtemplate}
@JsonSerializable()
class Hours {
  /// {@macro hours}
  const Hours({
    this.isOpenNow = false,
  });

  /// [Hours.fromJson] that returns an instance of [Hours]
  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [Hours]
  Map<String, dynamic> toJson() => _$HoursToJson(this);

  /// Boolean that indicates if is open now.
  @JsonKey(name: 'is_open_now')
  final bool isOpenNow;
}
