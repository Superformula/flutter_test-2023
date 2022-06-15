// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:restaurantour/main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:flutter/material.dart';

// Test on device: flutter run -t test/widget_test.dart
// flutter test test/widget_test.dart

void main() {

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Page loads', (WidgetTester tester) async {
    await tester.runAsync(() async {
      expect(YelpRepository().getRestaurants(), isA<Future<RestaurantQueryResult?>>());
      await tester.pumpAndSettle();
    });

    await tester.pumpWidget(const Restaurantour());
    await tester.pumpAndSettle();

    expect(find.text('RestauranTour'), findsOneWidget);
    expect(find.text('All Restaurants'), findsOneWidget);
    expect(find.text('My Favorites'), findsOneWidget);

    await tester.tap(find.text('My Favorites'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('All Restaurants'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byKey(const Key('AllRestaurantListView')), findsOneWidget);
  });
}
