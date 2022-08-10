import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/app.dart';
import 'package:restaurantour/presentation/screens/restarautour_home_screen.dart';
import 'package:restaurantour/presentation/widgets/all_restaurants_widget.dart';
import 'package:restaurantour/presentation/widgets/restaurant_list_tile.dart';

import 'utils/yelp_repository_mock.dart';

/// Quick test command: flutter test test/widget_test.dart
/// Test on device: flutter run -t test/widget_test.dart

void main() {
  group('RestauranTourHomeScreen', () {
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      HttpOverrides.global = null;
    });

    void testAppBarAndTabBar(WidgetTester tester) {
      final appBarFinder = find.byKey(RestauranTourHomeScreen.appBarKey).first;
      expect(appBarFinder, findsOneWidget);

      final appBar = tester.widget(appBarFinder) as AppBar;
      expect(appBar.backgroundColor, Colors.white);

      final appBarTitleStyleMatcher = isA<TextStyle>()
          .having((text) => text.color, 'color', Colors.black)
          .having((text) => text.fontFamily, 'fontFamily', 'VelourRaw')
          .having((text) => text.fontWeight, 'fontWeight', FontWeight.w600);

      final appBarTitleMatcher = isA<Text>().having(
        (text) => text.data,
        'data',
        RestauranTourHomeScreen.titleText,
      );

      expect(
        appBar.title,
        appBarTitleMatcher.having(
          (text) => text.style,
          'style',
          appBarTitleStyleMatcher,
        ),
      );

      final tabBarFinder = find.byKey(RestauranTourHomeScreen.tabBarKey).first;
      expect(tabBarFinder, findsOneWidget);

      final tabBar = tester.widget(tabBarFinder) as TabBar;
      expect(tabBar.indicatorColor, Colors.black);
      expect(tabBar.labelColor, Colors.black);
      expect(tabBar.indicatorSize, TabBarIndicatorSize.label);
      expect(tabBar.indicatorWeight, 2);
      expect(tabBar.tabs, hasLength(2));

      expect(
        tabBar.tabs.first,
        isA<Tab>().having(
          (tab) => tab.text,
          'text',
          RestauranTourHomeScreen.tabBarAllRestaurantsText,
        ),
      );

      expect(
        tabBar.tabs.last,
        isA<Tab>().having(
          (tab) => tab.text,
          'text',
          RestauranTourHomeScreen.tabBarMyFavoritesText,
        ),
      );
    }

    testWidgets('All restaurant tab with (3) restaurants', (
      WidgetTester tester,
    ) async {
      //
      await tester.pumpWidget(
        Restaurantour(
          // Create mock that get with 3 restaurants.
          yelpRepository: YelpRepositoryMock.withData(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      testAppBarAndTabBar(tester);

      final restaurantTitles = find.byType(RestaurantListTile);
      expect(restaurantTitles, findsNWidgets(3));

      final viewMoreButtonFinder = find.byType(MaterialButton);
      expect(viewMoreButtonFinder, findsOneWidget);

      var viewMoreButtonWidget =
          tester.widget(viewMoreButtonFinder) as MaterialButton;

      expect(
        viewMoreButtonWidget.child,
        isA<Text>().having(
          (text) => text.data,
          'data',
          AllRestaurantsWidget.viewMoreButtonText,
        ),
      );
    });

    testWidgets('All restaurant tab without restaurants', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        Restaurantour(yelpRepository: YelpRepositoryMock.noData()),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      testAppBarAndTabBar(tester);

      final noRestaurantsFoundWidget =
          find.text(AllRestaurantsWidget.noRestaurantFoundText);

      expect(noRestaurantsFoundWidget, findsOneWidget);
    });

    testWidgets('All restaurant tab with an error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        Restaurantour(yelpRepository: YelpRepositoryMock.error()),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      testAppBarAndTabBar(tester);

      final somethingWrongWidget =
          find.text(AllRestaurantsWidget.somethingWrongText);

      expect(somethingWrongWidget, findsOneWidget);
    });
  });
}
