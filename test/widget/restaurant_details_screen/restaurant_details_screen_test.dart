import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/screens/tabs/restaurants_screen.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';

import '../../viewmodel/tabs_vm/tabs_vm_test.dart';

void main() {
  testWidgets(
    'test RestaurantDetailsScreen',
        (WidgetTester tester) async {
      final vm = TabsVM();

      final restaurants =
          RestaurantQueryResult
              .fromJson(fakeRestaurants)
              .restaurants;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: vm,
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

      final node = find.byType(InkWell);

      await tester.tap(node.first);

      await tester.pumpAndSettle();

      expect(find.text('\$\$\$'), findsOneWidget);
      expect(find.text('New American'), findsOneWidget);
      expect(find.text('Address'), findsOneWidget);
      expect(find.text('4.4'), findsOneWidget);
      expect(find.byType(RatingBar), findsNWidgets(3));
      expect(find.byType(CachedNetworkImage),  findsNWidgets(2));
      expect(find.text('White R.'), findsOneWidget);
      expect(find.text('Molly S.'), findsOneWidget);
      expect(find.text('Taylor T.'), findsOneWidget);
      expect(find.text('Open Now'), findsOneWidget);
    },
  );
}