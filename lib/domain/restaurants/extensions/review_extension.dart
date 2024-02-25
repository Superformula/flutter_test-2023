import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurantour/domain/restaurants/extensions/extensions.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToReviewEntity on Review {
  ReviewEntity toEntity() => ReviewEntity(
        id: id,
        rating: rating,
        text: text,
        user: user?.toEntity(),
      );
}
