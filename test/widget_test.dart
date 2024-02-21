// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/application/list_restaurants_provider.dart';

import 'package:restaurantour/main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/presentation/atomic/atomic.dart';
import 'package:restaurantour/presentation/pages/package.dart';

class MockListRestaurantsProvider extends Mock
    implements ListRestaurantsProvider {}

void main() {
  late MockListRestaurantsProvider mockProvider;
  setUp(() async {
    mockProvider = MockListRestaurantsProvider();
  });

  testWidgets('Page inital load', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Restaurantour());
    // Verify that tests will run
    expect(find.text('Fetch Restaurants'), findsOneWidget);
  });

  testWidgets('ListViewPage widget shows loading indicator',
      (WidgetTester tester) async {
    when(() => mockProvider.isLoading).thenReturn(true);
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<ListRestaurantsProvider>.value(
        value: mockProvider,
        child: const ListViewPage(),
      ),
    ));

    expect(find.byKey(const Key('progress-indicator')), findsOneWidget);
  });

  testWidgets('ListViewPage widget shows restaurants list',
      (WidgetTester tester) async {
    when(() => mockProvider.isLoading).thenReturn(false);
    when(() => mockProvider.restaurants).thenReturn(const [
      Restaurant(
        name: 'Restaurant 1',
        price: "\$",
        id: "1",
        rating: 3.5,
      ),
      Restaurant(
        name: 'Restaurant 2',
        price: "\$",
        id: "2",
        rating: 3.5,
      ),
      Restaurant(
        name: 'Restaurant 3',
        price: "\$",
        id: "3",
        rating: 3.5,
      ),
    ]);
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<ListRestaurantsProvider>.value(
              value: mockProvider,
              child: const ListViewPage(),
            ),
          ),
        ));

    expect(find.byType(RestaurantCardMolecule), findsNWidgets(3));
  });
}
