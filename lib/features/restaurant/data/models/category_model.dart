import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  const CategoryModel({
    this.title,
    this.alias,
  });

  final String? alias;
  final String? title;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(
      title: title,
      alias: alias,
    );
  }
}
