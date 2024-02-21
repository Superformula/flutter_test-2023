import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/widgets/star_rating.dart';

void main() {
  testWidgets('StarRating displays correct number of stars', (WidgetTester tester) async {
    // Create a test widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StarRating(
            rating: 3.8,
            size: 24.0,
          ),
        ),
      ),
    );

    // Verify that the StarRating widget displays the correct number of stars
    expect(find.byIcon(Icons.star), findsNWidgets(4));
  });
}
