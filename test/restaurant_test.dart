import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'utils/fixture.dart';
import 'utils/other_object.dart';
import 'utils/restaurantour_matchers.dart';

void main() {
  group('Restaurant Class', () {
    Restaurant restaurant = TestFixture().restaurant();

    test('Equals, hashCode and copyWithWith', () {
      dynamic other;
      Restaurant otherRestaurant = restaurant.copyWith();

      // Reflexivity
      expect(otherRestaurant, otherRestaurant);
      expect(otherRestaurant.hashCode, otherRestaurant.hashCode);

      // Symmetry
      expect(otherRestaurant, same(otherRestaurant));
      expect(otherRestaurant, isNotSame(restaurant));

      // Transitivity
      expect(otherRestaurant, restaurant);
      expect(otherRestaurant.hashCode, restaurant.hashCode);

      // id
      other = OtherObject.withTheSameType(otherRestaurant.id);
      expect(other, isNot(otherRestaurant.id));
      otherRestaurant = restaurant.copyWith(id: other);
      expect(otherRestaurant.id, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // name
      other = OtherObject.withTheSameType(otherRestaurant.name);
      expect(other, isNot(otherRestaurant.name));
      otherRestaurant = restaurant.copyWith(name: other);
      expect(otherRestaurant.name, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // price
      other = OtherObject.withTheSameType(otherRestaurant.price);
      expect(other, isNot(otherRestaurant.price));
      otherRestaurant = restaurant.copyWith(price: other);
      expect(otherRestaurant.price, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // rating
      other = OtherObject.withTheSameType(otherRestaurant.rating);
      expect(other, isNot(otherRestaurant.rating));
      otherRestaurant = restaurant.copyWith(rating: other);
      expect(otherRestaurant.rating, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // photos
      other = OtherObject.withTheSameType(otherRestaurant.photos);
      expect(other, isNot(otherRestaurant.photos));
      otherRestaurant = restaurant.copyWith(photos: other);
      expect(otherRestaurant.photos, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // categories
      other = OtherObject.withTheSameType(otherRestaurant.categories);
      expect(other, isNot(otherRestaurant.categories));
      otherRestaurant = restaurant.copyWith(categories: other);
      expect(otherRestaurant.categories, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // hours
      other = OtherObject.withTheSameType(otherRestaurant.hours);
      expect(other, isNot(otherRestaurant.hours));
      otherRestaurant = restaurant.copyWith(hours: other);
      expect(otherRestaurant.hours, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // reviews
      other = OtherObject.withTheSameType(otherRestaurant.reviews);
      expect(other, isNot(otherRestaurant.reviews));
      otherRestaurant = restaurant.copyWith(reviews: other);
      expect(otherRestaurant.reviews, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));

      // location
      other = OtherObject.withTheSameType(otherRestaurant.location);
      expect(other, isNot(otherRestaurant.location));
      otherRestaurant = restaurant.copyWith(location: other);
      expect(otherRestaurant.location, other);
      expect(otherRestaurant, isNot(restaurant));
      expect(otherRestaurant.hashCode, isNot(restaurant.hashCode));
    });

    test('FromJson and ToJson', () {
      var json = restaurant.toJson();
      expect(Restaurant.fromJson(json), restaurant);
    });

    test('Getter displayCategory', () {
      expect(
        const Restaurant(categories: [Category(title: 'category-title')])
            .displayCategory,
        'category-title',
      );

      expect(const Restaurant(categories: []).displayCategory, '');

      expect(const Restaurant().displayCategory, '');

      expect(
        const Restaurant(categories: [Category(title: '')]).displayCategory,
        '',
      );
    });

    test('Getter heroImage', () {
      expect(
        const Restaurant(photos: ['first-photo', '']).heroImage,
        'first-photo',
      );

      expect(const Restaurant(photos: []).heroImage, '');
      expect(const Restaurant().heroImage, '');
      expect(const Restaurant(photos: ['']).heroImage, '');
    });

    test('Getter isOpen', () {
      expect(
        const Restaurant(
          hours: [Hours(isOpenNow: true), Hours(isOpenNow: false)],
        ).isOpen,
        isTrue,
      );

      expect(const Restaurant(hours: []).isOpen, isFalse);
      expect(const Restaurant().isOpen, isFalse);
      expect(const Restaurant(hours: [Hours()]).isOpen, isFalse);
    });
  });
}
