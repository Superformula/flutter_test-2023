import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/common/restaurant_card/restaurant_card.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/categories.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/image.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/price.dart';
import 'package:restaurantour/presentation/common/restaurant_card/widgets/title.dart';
import 'package:restaurantour/presentation/common/restaurant_rating/rating.dart';
import 'package:restaurantour/presentation/common/restaurant_status/restaurant_status.dart';

abstract class OnTap {
  void call();
}

class MockOnTap extends Mock implements OnTap {}

void main() {
  String id = '1';
  String name = 'Sample Restaurant';
  String price = '\$\$\$';
  double rating = 4.5;
  List<String> photos = [
    'https://s3-media1.fl.yelpcdn.com/bphoto/V_zmwCUG1o_vR29xfkb-ng/o.jpg',
    'https://example.com/photo2.jpg',
  ];
  List<Category> categories = [
    Category(title: 'Italian', alias: "Italian"),
    Category(title: 'Pasta'),
  ];
  List<Hours> hours = const [
    Hours(isOpenNow: true),
    Hours(isOpenNow: false),
  ];
  List<Review> reviews = const [
    Review(id: '1', text: 'Great food', rating: 5),
    Review(id: '2', text: 'Good service', rating: 4),
  ];

  late final Restaurant restaurant;

  setUpAll(() {
    HttpOverrides.global = null;

    restaurant = Restaurant(
      id: id,
      name: name,
      price: price,
      rating: rating,
      photos: photos,
      categories: categories,
      hours: hours,
      reviews: reviews,
    );
  });

  testWidgets(
    'RestaurantCard should display key widgets',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantCard(
            restaurant,
            onTap: () => {},
          ),
        ),
      );

      final imageWidget = find.byType(RestaurantCardImage);
      final titleWidget = find.byType(RestaurantCardName);
      final priceWidget = find.byType(RestaurantCardPrice);
      final categoriesWidget = find.byType(RestaurantCardCategories);
      final ratingWidget = find.byType(RestaurantRating);
      final statusWidget = find.byType(RestaurantStatus);

      expect(imageWidget, findsOneWidget);
      expect(titleWidget, findsOneWidget);
      expect(priceWidget, findsOneWidget);
      expect(categoriesWidget, findsOneWidget);
      expect(ratingWidget, findsOneWidget);
      expect(statusWidget, findsOneWidget);

      final cardTitle = tester.widget(titleWidget) as RestaurantCardName;
      expect(cardTitle.title, name);

      final cardPrice = tester.widget(priceWidget) as RestaurantCardPrice;
      expect(cardPrice.price, price);

      final cardCategories =
          tester.widget(categoriesWidget) as RestaurantCardCategories;
      expect(cardCategories.categories, categories);

      final cardRating = tester.widget(ratingWidget) as RestaurantRating;
      expect(cardRating.rating, restaurant.rating!.round());

      final cardStatus = tester.widget(statusWidget) as RestaurantStatus;
      expect(cardStatus.isOpenNow, restaurant.isOpen);
    },
  );

  testWidgets(
    'RestaurantCard should call onTap fn when tapped',
    (WidgetTester tester) async {
      final mockOnTap = MockOnTap();

      await tester.pumpWidget(
        MaterialApp(
          home: RestaurantCard(
            restaurant,
            onTap: mockOnTap,
          ),
        ),
      );

      final cardWdgt = find.byType(Card);

      await tester.tap(cardWdgt);

      verify(mockOnTap()).called(1);
    },
  );
}
