import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/features/restauran_tour/model/restauran_service.dart';
import 'package:restaurantour/features/restauran_tour/view/restauran_tour.dart';
import 'package:restaurantour/features/restauran_tour/view/restaurant_row_item.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';
import 'package:restaurantour/widgets/open_status.dart';
import 'package:restaurantour/widgets/rating.dart';
import 'mock_restauran_service.dart';

void main() {
  late RestauranService restauranService;

  setUp(() {
    restauranService = MockRestauranService();
  });

  Future<void> _createWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<RestaurantsViewModel>(
          create: (_) => RestaurantsViewModel(service: restauranService),
          child: const RestauranTour(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('All restaurant list loaded', (WidgetTester tester) async {
    /// Load the app with material app configuration
    await _createWidget(tester);

    ///Check of app bar loaded
    expect(find.byType(AppBar), findsOneWidget);

    ///check if app bar conatin title as 'RestauranTour'
    expect(find.text("RestauranTour"), findsOneWidget);

    /// Check if initial screen is laoded with two tab bars as 'All Resturants' and 'My Favorites'
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.widgetWithText(Tab, "All Resturants"), findsOneWidget);
    expect(find.widgetWithText(Tab, "My Favorites"), findsOneWidget);

    /// check the rows with restaurants got loaded. As per mock response it should load two rows.
    expect(find.byType(RestaurantRowItem), findsNWidgets(2));
    expect(find.byType(Rating), findsNWidgets(2));
    expect(find.byType(OpenStatus), findsNWidgets(2));

    /// check at end of list, should display 'View More' text button
    expect(find.text("View More"), findsOneWidget);

    /// Identify 'My Favorites' tab and tap on it
    Finder myFavoriteTab = find.widgetWithText(Tab, "My Favorites");
    await tester.tap(myFavoriteTab);
    await tester.pumpAndSettle();

    /// Ensure after tapping on 'My Favorites' tab should load MyFavorite screen with no items.
    expect(find.text("No items added as favorites"), findsOneWidget);
  });

  ///TODO: Navigation tetsing is failing need to fix it.
  // testWidgets('open restauran detail screen', (WidgetTester tester) async {
  //   await _createWidget(tester);
  //   expect(find.byType(RestaurantRowItem), findsNWidgets(2));
  //   Finder rowItem = find.byType(RestaurantRowItem).first;
  //   await tester.tap(rowItem);
  //   await tester.pump();
  //   expect(find.byType(ResturantDetailScreen), findsOneWidget);
  // });
}
