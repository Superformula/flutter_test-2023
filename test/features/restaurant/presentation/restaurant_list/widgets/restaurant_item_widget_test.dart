import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/widgets/restaurant_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../restaurant_mockup.dart';

void main() {
  testWidgets('RestaurantItemWidget should show correct data',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(
            body: RestaurantItemWidget(restaurant: restaurantMockup),
          ),
        ),
      );
      final nameFinder = find.text(restaurantMockup.name!);
      expect(nameFinder, findsOneWidget);
    });
  });

  testWidgets('RestaurantItemWidget should navigate when tapped',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(
            body: RestaurantItemWidget(restaurant: restaurantMockup),
          ),
          routes: {
            '/restaurant_detail': (context) => const Text('/restaurant_detail'),
          },
        ),
      );
      // Act
      await tester.tap(find.byType(RestaurantItemWidget));
      await tester.pumpAndSettle();

      expect(find.text('/restaurant_detail'), findsOneWidget);
    });
  });
}
