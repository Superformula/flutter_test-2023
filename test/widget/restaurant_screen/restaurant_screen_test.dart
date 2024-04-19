import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/screens/tabs/restaurants_screen.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';

import '../../viewmodel/tabs_vm/tabs_vm_test.dart';

void main() {
  testWidgets(
    'test RestaurantScreen loaded',
    (WidgetTester tester) async {
      final restaurants =
          RestaurantQueryResult.fromJson(fakeRestaurants).restaurants;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: TabsVM(),
            child: RestaurantsScreen(
              restaurants: restaurants!,
              loadStatus: LoadStatus.loaded,
            ),
          ),
        ),
      );

      await tester.pump(
        Durations.short3,
      );

      expect(find.text('Gordon Ramsay Hell\'s Kitchen'), findsOneWidget);
      expect(find.text('Yardbird'), findsOneWidget);
    },
  );

  testWidgets(
    'test RestaurantScreen loading',
    (WidgetTester tester) async {
      final vm = TabsVM();
      final restaurants =
          RestaurantQueryResult.fromJson(fakeRestaurants).restaurants;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: vm,
            child: RestaurantsScreen(
              restaurants: restaurants!,
              loadStatus: LoadStatus.loading,
            ),
          ),
        ),
      );

      await tester.pump(
        Durations.short3,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'test RestaurantScreen error',
    (WidgetTester tester) async {
      final vm = TabsVM();

      final restaurants =
          RestaurantQueryResult.fromJson(fakeRestaurants).restaurants;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: vm,
            child: RestaurantsScreen(
              restaurants: restaurants!,
              loadStatus: LoadStatus.error,
            ),
          ),
        ),
      );

      await tester.pump(
        Durations.short3,
      );

      expect(find.bySemanticsLabel("ERROR!"), findsOneWidget);
    },
  );
}
