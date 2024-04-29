import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/logic/favorites/favorites_cubit.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/pages/home/widgets/widgets.dart';
import 'package:restaurantour/pages/widgets/restaurants_list.dart';

import '../../../test_utils/mock_blocs.dart';
import '../../../test_utils/mock_wrapper.dart';

void main() {
  group('FavoriteList', () {
    testWidgets('Smoke - no restaurants', (tester) async {
      final FavoritesCubit favoritesCubit = MockFavoritesCubit();
      when(() => favoritesCubit.state).thenReturn(
        const FavoritesState(),
      );

      await tester.pumpWidget(
        MockWrapper(
          mockProviders: [
            BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
          ],
          child: const FavoriteList(),
        ),
      );

      expect(find.byType(FavoriteList), findsOneWidget);
      expect(find.byType(RestaurantsList), findsNothing);
    });

    testWidgets('Smoke - restaurants', (tester) async {
      final FavoritesCubit favoritesCubit = MockFavoritesCubit();
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
            BlocProvider<FavoritesCubit>.value(value: favoritesCubit),
          ],
          child: const FavoriteList(),
        ),
      );

      expect(find.byType(FavoriteList), findsOneWidget);
      expect(find.byType(RestaurantsList), findsOneWidget);
    });
  });
}
