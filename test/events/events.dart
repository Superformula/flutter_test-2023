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
  final restaurantCards = find.byType(RestaurantCard);
  expect(restaurantCards, findsWidgets);
  return tester.tap(restaurantCards.first);
}

Future<void> tapOnBorderedHeart(WidgetTester tester) async {
  final borderedHeart = find.byIcon(Icons.favorite_border);
  expect(borderedHeart, findsOneWidget);
  await tester.ensureVisible(borderedHeart);
  return tester.tap(borderedHeart);
}