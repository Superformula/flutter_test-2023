import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
abstract class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.imageUrl,
    this.name,
  });

  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    name,
  ];
}
