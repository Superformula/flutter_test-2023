import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/open_now_widget.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/restaurant_card.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/star_rating.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets(
    'RestaurantCard displays restaurant details',
    (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      Restaurant testRestaurant = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        price: '\$\$',
        categories: [Category(title: 'Test Category')],
        photos: [''],
        rating: 4.5,
        hours: [
          const Hours(isOpenNow: true),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: Scaffold(
            body: RestaurantCard(restaurant: testRestaurant, isTest: true),
          ),
        ),
      );

      expect(find.text('Test Restaurant'), findsOneWidget);
      expect(find.text('\$\$'), findsOneWidget);
      expect(find.text('Test Category'), findsOneWidget);
      expect(find.byType(StarRating), findsOneWidget);
      expect(find.byType(OpenNowWidget), findsOneWidget);
    },
  );
}
