import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToUserEntity on User {
  UserEntity toEntity() => UserEntity(
        id: id,
        imageUrl: imageUrl,
        name: name,
      );
}
