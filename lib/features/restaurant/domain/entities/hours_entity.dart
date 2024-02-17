import 'package:equatable/equatable.dart';

class HoursEntity extends Equatable {
  const HoursEntity({
    this.isOpenNow,
  });

  final bool? isOpenNow;

  @override
  List<Object?> get props => [
        isOpenNow,
      ];
}
