import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/features/restaurant/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    this.id,
    this.imageUrl,
    this.name,
  });

  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      imageUrl: imageUrl,
      name: name,
    );
  }
}
