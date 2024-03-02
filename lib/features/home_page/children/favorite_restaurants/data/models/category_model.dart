import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/category_entity.dart';

class CategoryModel {
  const CategoryModel(this.categoryEntity);
  final CategoryEntity categoryEntity;

  Map<String, dynamic> toJson() => {
        'title': categoryEntity.title,
        'alias': categoryEntity.alias,
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      (
        title: json['title'] ?? '',
        alias: json['alias'] ?? '',
      ),
    );
  }
}
