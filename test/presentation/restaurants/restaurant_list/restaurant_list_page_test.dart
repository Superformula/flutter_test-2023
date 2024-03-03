import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/dependency_injection/di_locator.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/restaurants/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/domain/restaurants/use_cases/watch_favorite_restaurants_use_case.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_page.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_view_model.dart';
import 'package:restaurantour/presentation/utils/constants.dart';

import '../../../test_utils/mocks.mocks.dart';

void main() {
  group('RestaurantListPage widget test', () {
    final mockRestaurantListViewModel = MockRestaurantListViewModel();
    final mockGetRestaurantsUseCase = MockGetRestaurantsUseCase();
    final mockWatchFavoriteRestaurantsUseCase =
        MockWatchFavoriteRestaurantsUseCase();

    setUpAll(() {
      testRegister<GetRestaurantsUseCase>(mockGetRestaurantsUseCase);
      testRegister<WatchFavoriteRestaurantsUseCase>(
          mockWatchFavoriteRestaurantsUseCase);
      testRegister<RestaurantListViewModel>(mockRestaurantListViewModel);
    });

    tearDownAll(() {
      locator.reset();
    });

    testWidgets('should show CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(mockRestaurantListViewModel.isLoading).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(home: RestaurantListPage()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when has error',
        (WidgetTester tester) async {
      when(mockRestaurantListViewModel.isLoading).thenReturn(false);
      when(mockRestaurantListViewModel.hasError).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(home: RestaurantListPage()),
      );

      expect(find.text(Constants.errorFetching), findsOneWidget);
    });

    testWidgets('should show ListView when has data',
        (WidgetTester tester) async {
      when(mockRestaurantListViewModel.isLoading).thenReturn(false);
      when(mockRestaurantListViewModel.hasError).thenReturn(false);
      when(mockRestaurantListViewModel.hasData).thenReturn(true);
      when(mockRestaurantListViewModel.restaurants).thenReturn(
        [
          const RestaurantEntity(
            id: '1',
            name: 'Restaurant 1',
            rating: 4.5,
            reviews: [],
            isOpen: false,
            price: '££',
            heroImage: '',
            category: 'Category',
            address: 'Address',
          ),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(home: RestaurantListPage()),
      );

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
