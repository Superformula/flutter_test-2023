import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurantour/domain/restaurants/extensions/extensions.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

extension ConvertToRestaurantEntity on Restaurant {
  RestaurantEntity toEntity() => RestaurantEntity(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photos: photos,
        categories: categories?.map((category) => category.toEntity()).toList(),
        hours: hours?.map((hour) => hour.toEntity()).toList(),
        reviews: reviews?.map((review) => review.toEntity()).toList(),
        location: location?.toEntity(),
      );
}
