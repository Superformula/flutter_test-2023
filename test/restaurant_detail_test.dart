import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/modules/restaurant/views/restaurant_detail_view.dart';
import 'package:restaurantour/widgets/review_item_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Mock restaurant data
  final Restaurant mockRestaurant = Restaurant(
    name: "Mock Restaurant",
    price: "30-50",
    photos: ["https://i.pravatar.cc", "https://i.pravatar.cc"],
    location: Location(formattedAddress: "123 Mock Street"),
    rating: 4.5,
    reviews: [
      const Review(
        rating: 5,
        user: User(name: "John Doe", imageUrl: "https://i.pravatar.cc"),
      ),
    ],
  );

  testWidgets('RestaurantDetailView displays restaurant data correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RestaurantDetailView(
          restaurantIndex: 1,
          restaurant: mockRestaurant,
        ),
      ),
    );

    // Verify that the restaurant's name, price, open status, and address are displayed.
    expect(find.text('Mock Restaurant'), findsOneWidget);
    expect(find.text('\$ 30-50'), findsOneWidget);
    expect(find.text('123 Mock Street'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.byType(Icon), findsWidgets);
    expect(find.byType(Hero), findsOneWidget);
    // expect(find.byType(Image), findsWidgets);
    expect(
      find.byType(ReviewListTile),
      findsNWidgets(mockRestaurant.reviews!.length),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    final Hero heroWidget = tester.firstWidget(find.byType(Hero)) as Hero;
    expect(heroWidget.tag, equals('hero-restaurant-image-1'));
  });
}
