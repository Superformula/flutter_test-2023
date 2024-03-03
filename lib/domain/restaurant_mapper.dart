import 'package:restaurantour/domain/exceptions/mapper_exception.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/entities/review_entity.dart';
import 'package:restaurantour/domain/restaurants/entities/user_entity.dart';

/// Handles mapping from Restaurant model to Restaurant entity (local)
class RestaurantMapper {
  // Maps the restaurant model to restaurant entity
  static RestaurantEntity fromModel(Restaurant model) {
    if (model.id == null || model.name == null || model.name!.isEmpty) {
      throw MapperException('Invalid restaurant model');
    }

    final List<ReviewEntity> reviews = model.reviews
            ?.map(
              (review) => ReviewEntity(
                id: review.id ?? '',
                userId: review.user?.id ?? '',
                comment: review.text ?? '',
                rating: review.rating ?? 0,
                author: UserEntity(
                  id: review.user?.id ?? '',
                  name: review.user?.name ?? '',
                  profileImageUrl: review.user?.imageUrl ?? '',
                ),
              ),
            )
            .toList() ??
        [];

    return RestaurantEntity(
      id: model.id ?? '',
      name: model.name ?? '',
      price: model.price ?? '',
      rating: model.rating ?? 0.0,
      heroImage: model.photos?.first ?? '',
      isOpen: model.isOpen,
      reviews: reviews,
      category: model.categories?.first.title ?? '',
    );
  }

  // Maps the restaurant model list to restaurant entity list
  static List<RestaurantEntity> fromModelList(List<Restaurant> modelList) {
    return modelList.map((model) => fromModel(model)).toList();
  }
}
