import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/category_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/hour_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/location_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/review_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/user_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/restaurant_entity.dart';

void main() {
  group('RestaurantEntity', () {

    const id = '1';
    const name = 'Test Restaurant';
    const price = '\$\$';
    const rating = 4.5;
    final photos = ['photo1.jpg', 'photo2.jpg'];
    final reviews = [
      const ReviewModel(
          id: 'review1',
          user: UserModel(id: 'asdf', name: 'TEST USER', imageUrl: ''),
          rating: 5,
          text: 'Great!')
    ];
    final categories = [
      const CategoryModel(title: 'Italian', alias: 'italian')
    ];
    final hours = [const HourModel(isOpenNow: true)];
    const location = LocationModel(formattedAddress: '123 Test St');

    test('should correctly assign properties', () {
      final restaurantEntity = RestaurantEntity(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photos: photos,
        reviews: reviews,
        categories: categories,
        hours: hours,
        location: location,
      );

      expect(restaurantEntity.id, id);
      expect(restaurantEntity.name, name);
      expect(restaurantEntity.price, price);
      expect(restaurantEntity.rating, rating);
      expect(restaurantEntity.photos, photos);
      expect(restaurantEntity.reviews, reviews);
      expect(restaurantEntity.categories, categories);
      expect(restaurantEntity.hours, hours);
      expect(restaurantEntity.location, location);
    });
  });
}
