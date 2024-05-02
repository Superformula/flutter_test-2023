import 'package:objectbox/objectbox.dart';
import 'package:domain_models/domain_models.dart' as domain;

@Entity()
class Restaurant {
  /// Unique ID for ObjectBox
  @Id()
  int primaryKey;

  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final String? photoUrl;
  final String? category;
  final bool? isOpen;
  final String? address;

  Restaurant({
    this.primaryKey = 0,
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photoUrl,
    this.category,
    this.isOpen,
    this.address,
  });

  Restaurant.fromDomainModel(domain.Restaurant restaurant)
      : primaryKey = 0,
        id = restaurant.id,
        name = restaurant.name,
        price = restaurant.price,
        rating = restaurant.rating,
        photoUrl = restaurant.photoUrl,
        category = restaurant.category,
        isOpen = restaurant.isOpen,
        address = restaurant.address;

  domain.Restaurant toDomainModel() => domain.Restaurant(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photoUrl: photoUrl,
        category: category,
        isOpen: isOpen,
        address: address,
      );
}
