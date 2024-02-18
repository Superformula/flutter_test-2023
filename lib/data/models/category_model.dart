import 'package:restaurantour/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required String title,
    required String alias,
  }) : super(
          title: title,
          alias: alias,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json['title'],
        alias: (json['alias']),
      );
}
