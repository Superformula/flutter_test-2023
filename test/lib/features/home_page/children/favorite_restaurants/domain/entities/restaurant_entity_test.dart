import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/category_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/hour_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/location_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/review_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/restaurant_entity.dart';

class MockReviewModel extends Mock implements ReviewModel {}

class MockCategoryModel extends Mock implements CategoryModel {}

class MockHourModel extends Mock implements HourModel {}

class MockLocationModel extends Mock implements LocationModel {}

void main() {
  group(
    'RestaurantEntity Test',
    () {
      test(
        'RestaurantEntity should correctly assign properties',
        () {
          final mockReviewModel = MockReviewModel();
          final mockCategoryModel = MockCategoryModel();
          final mockHourModel = MockHourModel();
          final mockLocationModel = MockLocationModel();

          final restaurantEntity = RestaurantEntity(
            id: '1',
            name: 'Test Restaurant',
            price: '\$\$',
            rating: 4.5,
            photos: ['photo1.jpg', 'photo2.jpg'],
            reviews: [mockReviewModel],
            categories: [mockCategoryModel],
            hours: [mockHourModel],
            location: mockLocationModel,
          );
          expect(restaurantEntity.id, '1');
        },
      );
    },
  );
}
