import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// {@template category}
/// Category model
/// {@endtemplate}
@JsonSerializable()
class Category {
  /// {@macro category}
  const Category({
    this.alias = '',
    this.title = '',
  });

  /// [Category.fromJson] that returns an instance of [Category]
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// [toJson] that returns an instance a Map<String, dynamic> from [Category]
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  /// Alias of the category.
  final String alias;

  /// Title of the category.
  final String title;
}
