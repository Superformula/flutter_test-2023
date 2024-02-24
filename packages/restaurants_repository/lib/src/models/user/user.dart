import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// User model
/// {@endtemplate}
@JsonSerializable()
class User {
  /// {@macro user}
  const User({
    this.id = '',
    this.imageUrl,
    this.name = '',
  });

  /// [User.fromJson] that returns an instance of [User]
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [User]
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Id of the user.
  final String id;

  /// Image url of the user.
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Name of the user.
  final String name;
}
