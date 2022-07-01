// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/all_restaurants/all_restaurants_main.dart';
import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/view_model/favorite_model.dart';
import 'package:restaurantour/view_model/restaurant_model.dart';

import 'test_util.dart';

/// Quick test command: flutter test test/widget_test.dart
/// Test on device: flutter run -t test/widget_test.dart

void main() {
  late List<Restaurant> restaurants;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Success data = TestUtil.restaurantData();
    if (data.response is RestaurantQueryResult) {
      RestaurantQueryResult queryResult =
          data.response as RestaurantQueryResult;
      restaurants = queryResult.restaurants!;
    }
  });

  testWidgets('Page loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => RestaurantModel(restaurants: restaurants)),
            ChangeNotifierProvider(
                create: (_) => FavoriteModel(restaurants: restaurants)),
          ],
          child: const AllRestaurantsMain(),
        ),
      ),
    );

    expect(find.byKey(const Key('AllRestaurantListView')), findsOneWidget);
    await tester.drag(find.byKey(const Key('AllRestaurantListView')),
        const Offset(0.0, -500.0));

    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
