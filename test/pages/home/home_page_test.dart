import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/localization/localization.dart';
import 'package:restaurantour/logic/favorites/favorites_cubit.dart';
import 'package:restaurantour/logic/restaurant/restaurant_bloc.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/pages/home/widgets/widgets.dart';
import 'package:restaurantour/pages/pages.dart';
import 'package:restaurantour/pages/widgets/restaurant_list_tile.dart';

import '../../test_utils/helper_functions.dart';
import '../../test_utils/mock_blocs.dart';
import '../../test_utils/mock_wrapper.dart';

void main() {
  group('HomePage', () {
    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await loadEnglishLocalizations();
    });

    testWidgets('Smoke', (tester) async {
      final RestaurantBloc restaurantBloc = MockRestaurantBloc();
      final FavoritesCubit favoritesCubit = MockFavoritesCubit();

      when(() => restaurantBloc.state).thenReturn(
        const RestaurantState.success(restaurants: []),
      );
      when(() => favoritesCubit.state).thenReturn(
        const FavoritesState(),
      );

      await tester.pumpWidget(
        MockWrapper(
          mockProviders: [
            BlocProvider<RestaurantBloc>.value(value: restaurantBloc),
            BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
          ],
          child: const HomePage(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byType(AllRestaurantList), findsOneWidget);
      expect(find.text(l10n.allRestaurants), findsOneWidget);
      expect(find.text(l10n.myFavorites), findsOneWidget);
    });

    testWidgets('Change tab', (tester) async {
      final RestaurantBloc restaurantBloc = MockRestaurantBloc();
      final FavoritesCubit favoritesCubit = MockFavoritesCubit();

      when(() => restaurantBloc.state).thenReturn(
        const RestaurantState.success(restaurants: []),
      );
      when(() => favoritesCubit.state).thenReturn(
        const FavoritesState(
          restaurants: [
            Restaurant.test(),
          ],
        ),
      );

      await tester.pumpWidget(
        MockWrapper(
          mockProviders: [
            BlocProvider<RestaurantBloc>.value(value: restaurantBloc),
            BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
          ],
          child: const HomePage(),
        ),
      );

      expect(find.byType(AllRestaurantList), findsOneWidget);
      expect(find.byType(RestaurantListTile), findsNothing);
      expect(find.byType(FavoriteList), findsNothing);

      await tester.tap(find.text(l10n.myFavorites));
      await tester.pumpAndSettle();

      expect(find.byType(AllRestaurantList), findsNothing);
      expect(find.byType(FavoriteList), findsOneWidget);
      expect(find.byType(RestaurantListTile), findsOneWidget);
    });
  });
}
