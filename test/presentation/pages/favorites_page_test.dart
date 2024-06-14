import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/business_logic/favorite/favorite_state.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/presentation/pages/favorites_page.dart';
import 'package:restaurantour/presentation/widgets/restaurant_card_widget.dart';

class MockFavoriteCubit extends MockCubit<FavoriteState>
    implements FavoriteCubit {}

late FavoriteCubit favoriteCubit;

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    () => HttpOverrides.global = null;
    favoriteCubit = MockFavoriteCubit();
  });

  tearDown(
    () {
      favoriteCubit.close();
    },
  );

  testWidgets('Find one favorited restaurant', (tester) async {
    when(() => favoriteCubit.loadFavorites()).thenAnswer(
      (_) async => Future.value(),
    );

    when(() => favoriteCubit.state).thenReturn(
      FavoriteState(
        status: FavoriteStatus.success,
        favorites: [_restaurant],
      ),
    );

    await mockNetworkImagesFor(() => _createWidget(tester, [_restaurant]));

    await tester.pumpAndSettle();

    expect(find.byType(RestaurantCardWidget), findsOneWidget);
  });

  testWidgets('Find two favorited restaurant', (tester) async {
    when(() => favoriteCubit.loadFavorites()).thenAnswer(
      (_) async => Future.value(),
    );

    when(() => favoriteCubit.state).thenReturn(
      FavoriteState(
        status: FavoriteStatus.success,
        favorites: _restaurantList,
      ),
    );

    await mockNetworkImagesFor(() => _createWidget(tester, _restaurantList));

    await tester.pumpAndSettle();

    expect(find.byType(RestaurantCardWidget), findsNWidgets(2));
  });
}

Future<void> _createWidget(
  WidgetTester tester,
  List<Restaurant> restaurants,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: BlocProvider.value(
          value: favoriteCubit,
          child: FavoritesPage(
            restaurants: restaurants,
          ),
        ),
      ),
    ),
  );
}

Restaurant _restaurant = const Restaurant(id: '1', name: 'Pollos hermanos');
List<Restaurant> _restaurantList = [
  const Restaurant(id: '1', name: 'Pollos hermanos'),
  const Restaurant(id: '2', name: 'Pizza Planet'),
];
