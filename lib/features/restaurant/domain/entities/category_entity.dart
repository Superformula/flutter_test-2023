import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
abstract class CategoryEntity extends Equatable {
  const CategoryEntity({
    this.title,
    this.alias,
  });

  final String? alias;
  final String? title;

  @override
  List<Object?> get props => [
        alias,
        title,
      ];
}
