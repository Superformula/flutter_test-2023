import 'package:restaurantour/data/exceptions/mapper_exception.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';

/// Handles mapping from Restaurant model to Restaurant entity (local)
class RestaurantMapper {
  // Maps the restaurant model to restaurant entity
  static RestaurantEntity fromModel(Restaurant model) {
    if (model.id == null || model.name == null || model.name!.isEmpty) {
      throw MapperException('Invalid restaurant model');
    }
    return RestaurantEntity(
      id: model.id ?? '',
      name: model.name ?? '',
      price: model.price ?? '',
      rating: model.rating ?? 0.0,
      heroImage: model.photos?.first ?? '',
      isOpen: model.isOpen,
    );
  }

  // Maps the restaurant model list to restaurant entity list
  static List<RestaurantEntity> fromModelList(List<Restaurant> modelList) {
    return modelList.map((model) => fromModel(model)).toList();
  }
}
