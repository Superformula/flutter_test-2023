import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
abstract class HoursEntity extends Equatable {
  const HoursEntity({
    this.isOpenNow,
  });

  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  @override
  List<Object?> get props => [
        isOpenNow,
      ];
}
