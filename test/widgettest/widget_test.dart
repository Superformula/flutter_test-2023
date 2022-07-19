/// Copyright 2022 - Superformula. All rights reserved.

/// This is a basic Flutter widget test.
///
///To perform an interaction with a widget in your test, use the WidgetTester
/// utility that Flutter provides. For example, you can send tap and scroll
/// gestures. You can also use WidgetTester to find child widgets in the widget
/// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurantour/main.dart';
import 'package:restaurantour/widgets/allrestaurants.dart';
import 'package:restaurantour/widgets/favouriterestaurants.dart';
import 'package:restaurantour/widgets/restaurantdetails.dart';
import 'package:restaurantour/providers/restaurantsprovider.dart';
import 'package:restaurantour/models/restaurant.dart';

void main() {
  group("Restaurant Tour Widget Test", () {
    //call the Main widget
    testWidgets('Showing Restaurants Main Widget', (WidgetTester tester) async {
      //find all widgets needed
      const wKey = Key("RestaurantTour");

      //Execute the actual test
      await tester.pumpWidget(const RestaurantHome());

      //rebuild the Widget
      await tester.pump(const Duration(seconds: 1));

      // Verify that tests will pass RestaurantHome
      expect(find.byKey(wKey), findsOneWidget);
    });

    //call the Home widget
    testWidgets('Showing Restaurants Home Page', (WidgetTester tester) async {
      //find all widgets needed
      const wKey = Key("AllRestaurantsHome");

      //Execute the actual test
      await tester.pumpWidget(
          ChangeNotifierProvider<RestaurantsProvider>(create: (context) => RestaurantsProvider(), child: MaterialApp(home: RestaurantHomePage())));

      //rebuild the Widget
      await tester.pump(const Duration(seconds: 1));

      // Verify that tests will pass RestaurantHomePage
      expect(find.byKey(wKey), findsOneWidget);
    });

    //call the All Restaurants widget
    testWidgets('Showing All Restaurants Widget', (WidgetTester tester) async {
      //find all widgets needed
      const wKey = Key("AllRestaurants");

      //Execute the actual test
      await tester.pumpWidget(
          ChangeNotifierProvider<RestaurantsProvider>(create: (context) => RestaurantsProvider(), child: MaterialApp(home: AllRestaurants())));

      //rebuild the Widget
      await tester.pump(const Duration(seconds: 1));

      // Verify that tests will pass AllRestaurants
      expect(find.byKey(wKey), findsOneWidget);
    });

    //call the Favourite Restaurants widget
    testWidgets('Showing All Favourite Restaurants Widget', (WidgetTester tester) async {
      //find all widgets needed
      const wKey = Key("FavouriteRestaurants");

      //Execute the actual test
      await tester.pumpWidget(
          ChangeNotifierProvider<RestaurantsProvider>(create: (context) => RestaurantsProvider(), child: MaterialApp(home: FavouriteRestaurants())));

      //rebuild the Widget
      await tester.pump(const Duration(seconds: 1));

      // Verify that tests will pass FavouriteRestaurants
      expect(find.byKey(wKey), findsOneWidget);
    });

    //call the Restaurants Details widget
    testWidgets('Showing Restaurant details Widget', (WidgetTester tester) async {
      //find all widgets needed
      const wKey = Key("RestaurantDetails");

      //define the Restaurat map as a passing argument
      Map<String, dynamic> rMap = {
        'id': 'fdfd',
        'name': 'fdfd',
        'price': '',
        'rating': 5.0,
        'photos': [''],
        'categories': [
          {'title': '', 'alias': ''}
        ],
        'hours': [
          {'isOpenNow': true}
        ],
        'reviews': [],
        'location': {'formattedAddress': ''}
      };

      //Get the Restaurant object by calling Restaurant factory
      var restaurant = Restaurant.fromJson(rMap);

      //Execute the actual test
      await tester.pumpWidget(ChangeNotifierProvider<RestaurantsProvider>(
          create: (context) => RestaurantsProvider(),
          child: MaterialApp(home: Navigator(onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => RestaurantDetails(), settings: RouteSettings(arguments: {"restaurant": restaurant}));
          }))));

      //rebuild the Widget
      await tester.pump(const Duration(seconds: 1));

      // Verify that tests will pass RestaurantDetails
      expect(find.byKey(wKey), findsOneWidget);
    });
  });
}
