import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  final String? alias;
  final String? title;

  CategoryDto({
    this.alias,
    this.title,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);
  factory CategoryDto.fixture() => CategoryDto(alias: 'newamerican', title: 'New American');

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
