import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_list/restaurant_list.dart';

Future<void> tapOnFavoritesTab(WidgetTester tester) async {
  final favoritesTab = find.byKey(restaurantListFavoritesRestaurantsTabKey);
  expect(favoritesTab, findsOneWidget);
  await tester.ensureVisible(favoritesTab);
  return tester.tap(favoritesTab);
}

Future<void> tapOnAllRestaurantsTab(WidgetTester tester) async {
  final allRestaurantsTab = find.byKey(restaurantListAllRestaurantsTabKey);
  expect(allRestaurantsTab, findsOneWidget);
  await tester.ensureVisible(allRestaurantsTab);
  return tester.tap(allRestaurantsTab);
}

Future<void> tapFirstRestaurantCard(WidgetTester tester) async {
  final restaurantCard = find.byType(RestaurantCard);
  expect(restaurantCard, findsWidgets);
  final firstRestaurantCard = find.descendant(
    of: restaurantCard.first,
    matching: find.byType(RestaurantCard),
  );
  expect(firstRestaurantCard, findsOneWidget);
  await tester.ensureVisible(firstRestaurantCard);
  return tester.tap(firstRestaurantCard);
}

Future<void> tapOnBorderedHeart(WidgetTester tester) async {
  final borderedHeart = find.byIcon(Icons.favorite_border);
  expect(borderedHeart, findsOneWidget);
  await tester.ensureVisible(borderedHeart);
  return tester.tap(borderedHeart);
}