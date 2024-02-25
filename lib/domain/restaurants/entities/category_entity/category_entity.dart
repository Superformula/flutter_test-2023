import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  const CategoryEntity({
    this.alias = '',
    this.title = '',
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  final String alias;

  final String title;
}
