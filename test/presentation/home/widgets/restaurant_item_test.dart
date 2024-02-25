import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/domain/restaurants/entities/entities.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/home/widgets/widgets.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('RestaurantItem', () {
    const restaurant = RestaurantEntity(
      name: 'Restaurant name',
      price: '10',
      photos: ['https:/testing'],
      categories: [
        CategoryEntity(alias: 'Category alias', title: 'Category title'),
      ],
      hours: [
        HoursEntity(isOpenNow: true),
      ],
    );
    const restaurantClosed = RestaurantEntity(
      name: 'Restaurant name',
      price: '10',
      categories: [
        CategoryEntity(alias: 'Category alias', title: 'Category title'),
      ],
      hours: [
        HoursEntity(isOpenNow: false),
      ],
    );

    testWidgets(
      'renders right subwidgets',
      (tester) async {
        await tester.pumpApp(
          const RestaurantItem(restaurant: restaurant),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(Text), findsAtLeastNWidgets(1));
        expect(find.byType(RestaurantInfo), findsOneWidget);
        expect(find.byType(Stars), findsOneWidget);
        expect(find.byType(RestaurantStatus), findsOneWidget);
      },
    );

    testWidgets('renders right content of subwidget Text', (tester) async {
      await tester.pumpApp(
        const RestaurantItem(restaurant: restaurant),
      );

      expect(find.text(restaurant.name), findsOneWidget);
    });

    testWidgets('renders right content of subwidget RestaurantInfo',
        (tester) async {
      await tester.pumpApp(
        const RestaurantItem(restaurant: restaurant),
      );

      expect(
        find.descendant(
          of: find.byType(RestaurantInfo),
          matching:
              find.text('${restaurant.price} ${restaurant.displayCategory}'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders right content of subwidget Stars', (tester) async {
      await tester.pumpApp(
        const RestaurantItem(restaurant: restaurant),
      );

      expect(
        find.descendant(
          of: find.byType(Stars),
          matching: find.byType(RatingBarIndicator),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders right content of subwidget RestaurantStatus when restaurant is open',
        (tester) async {
      await tester.pumpApp(
        const RestaurantItem(restaurant: restaurant),
      );

      expect(
        find.descendant(
          of: find.byType(RestaurantStatus),
          matching: find.text('Open Now'),
        ),
        findsOneWidget,
      );

      final theme = lightAppThemeData().extension<RestauranTourTheme>()!;
      final circleContainer =
          find.byType(Circle).evaluate().first.widget as Circle;
      expect(circleContainer.color, equals(theme.colors.open));
    });

    testWidgets(
        'renders right content of subwidget RestaurantStatus when restaurant is open',
        (tester) async {
      await tester.pumpApp(
        const RestaurantItem(restaurant: restaurantClosed),
      );

      expect(
        find.descendant(
          of: find.byType(RestaurantStatus),
          matching: find.text('Closed'),
        ),
        findsOneWidget,
      );

      final theme = lightAppThemeData().extension<RestauranTourTheme>()!;
      final circleContainer =
          find.byType(Circle).evaluate().first.widget as Circle;
      expect(circleContainer.color, equals(theme.colors.closed));
    });
  });
}
