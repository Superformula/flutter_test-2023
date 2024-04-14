// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';

import 'package:restaurantour/widgets/restaurant_card_widget.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

void main() {
  testWidgets('BuildRestaurantItem displays restaurant name',
      (WidgetTester tester) async {
    // Mock restaurant data
    final mockRestaurant = Restaurant(id: '1', name: 'Test Restaurant');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BuildRestaurantItem(
            restaurantData: mockRestaurant,
          ),
        ),
      ),
    );

    // Verify that the RestaurantCardWidget is displaying the correct name
    expect(find.byType(RestaurantCardWidget), findsOneWidget);
    expect(find.text('Test Restaurant'), findsOneWidget);
  });
}
