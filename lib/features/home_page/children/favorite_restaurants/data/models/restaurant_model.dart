import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/category_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/hour_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/location_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/review_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.price,
    required super.rating,
    required super.photos,
    required super.reviews,
    required super.categories,
    required super.hours,
    required super.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'photos': photos,
      'reviews': reviews.map((review) => (review).toJson()).toList(),
      'categories': categories.map((category) => (category).toJson()).toList(),
      'hours': hours.map((hour) => (hour).toJson()).toList(),
      'location': (location).toJson(),
    };
  }

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    var businessJson = json['data']['business'] as Map<String, dynamic>;
    final id = businessJson['id'];
    final name = businessJson['name'] ?? '';
    final price = businessJson['price'] ?? '';
    final rating = (businessJson['rating'] ?? 0.0).toDouble();
    final photos = List<String>.from(businessJson['photos'] ?? []);
    final reviews = (businessJson['reviews'] as List<dynamic>? ?? [])
        .map((x) => ReviewModel.fromJson(x as Map<String, dynamic>))
        .toList();
    final categories = (businessJson['categories'] as List<dynamic>? ?? [])
        .map((x) => CategoryModel.fromJson(x as Map<String, dynamic>))
        .toList();
    final hours = (businessJson['hours'] as List<dynamic>? ?? [])
        .map((x) => HourModel.fromJson(x as Map<String, dynamic>))
        .toList();
    final locationJson = businessJson['location'] as Map<String, dynamic>?;
    final location =  LocationModel.fromJson(locationJson!);

    return RestaurantModel(
      id: id,
      name: name,
      price: price,
      rating: rating,
      photos: photos,
      reviews: reviews,
      categories: categories,
      hours: hours,
      location:location,
    );
  }

}
