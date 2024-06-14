import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/business_logic/favorite/favorite_state.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/presentation/pages/restaurants_page.dart';

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

late FavoriteCubit favoriteCubit;
void main() {
  setUp(() => favoriteCubit = MockFavoriteCubit());

  tearDown(() => favoriteCubit.close());

  group('Snack bar tests', () {
    testWidgets('Should show favorited snack bar', (tester) async {
      await tester.runAsync(
        () async {
          final state = StreamController<FavoriteState>();

          whenListen(
            favoriteCubit,
            state.stream,
            initialState: FavoriteState(),
          );

          await mockNetworkImagesFor(() => _createWidget(tester));

          state.add(FavoriteState(status: FavoriteStatus.favoriteSuccess));

          await tester.pumpAndSettle();

          expect(find.text('You favorited this restaurant!'), findsOneWidget);
        },
      );
    });

    testWidgets('Should show removed snack bar', (tester) async {
      await tester.runAsync(
        () async {
          final state = StreamController<FavoriteState>();

          whenListen(
            favoriteCubit,
            state.stream,
            initialState: FavoriteState(),
          );

          await mockNetworkImagesFor(() => _createWidget(tester));

          state.add(FavoriteState(status: FavoriteStatus.removed));

          await tester.pumpAndSettle();

          expect(find.text('You unfavorited this restaurant!'), findsOneWidget);
        },
      );
    });
  });

  testWidgets('Find page appbar and  body', (tester) async {
    when(() => favoriteCubit.state).thenReturn(FavoriteState());

    await mockNetworkImagesFor(() => _createWidget(tester));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: favoriteCubit,
        child: RestaurantPage(
          restaurant: _restaurant,
        ),
      ),
    ),
  );
}

Restaurant _restaurant = const Restaurant(name: 'Pollos hermanos', id: '1');
