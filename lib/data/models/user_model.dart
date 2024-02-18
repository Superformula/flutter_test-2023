import 'package:restaurantour/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  
  const UserModel({
    required String id,
    required String imageUrl,
    required String name,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          name: name,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    imageUrl: json['image_url'],
    name: json['user'],
  );
}
