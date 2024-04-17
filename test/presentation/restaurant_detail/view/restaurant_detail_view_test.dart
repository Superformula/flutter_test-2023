import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/di/di.dart';
import 'package:restaurantour/core/utils/status_enum.dart';

import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/presentation/restaurant_detail/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_detail/views/views.dart';

import '../../../mocks/restaurant_mock.dart';

class MockFavoriteRestaurantsCubit extends Mock
    implements FavoriteRestaurantsCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFavoriteRestaurantsCubit favoriteRestaurantsCubit;

  RestaurantEntity restaurantEntity = RestaurantMock.restarantEntity;
  List<RestaurantEntity> restaurantList = [restaurantEntity];

  setUpAll(() async {
    HttpOverrides.global = null;
  });

  setUp(() async {
    favoriteRestaurantsCubit = MockFavoriteRestaurantsCubit();

    await GetIt.I.reset();
    getIt.registerSingleton<FavoriteRestaurantsCubit>(favoriteRestaurantsCubit);
  });

  testWidgets(
      'RestaurantDetailView test - should find all the widgets below by key',
      (WidgetTester tester) async {
    when(() => favoriteRestaurantsCubit.state).thenReturn(
      const FavoriteRestaurantsListState(
        status: StatusEnum.success,
        restaurantsList: [],
      ),
    );

    final state = FavoriteRestaurantsListState(
      status: StatusEnum.success,
      restaurantsList: restaurantList,
    );

    when(() => favoriteRestaurantsCubit.stream)
        .thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<FavoriteRestaurantsCubit>.value(
            value: favoriteRestaurantsCubit,
            child: RestaurantDetailView(
              restaurant: restaurantEntity,
            ),
          ),
        ),
      ),
    );

    Finder scaffold = find.byKey(const ValueKey('scaffold'));
    Finder appBar = find.byKey(const ValueKey('appBar'));
    Finder restaurantHeroImageWidget =
        find.byKey(const ValueKey('restaurant-hero-image-widget'));
    Finder categoryBusinessHoursWidget =
        find.byKey(const ValueKey('price-category-business-hours-widget'));
    Finder addressOverallRatingWidget =
        find.byKey(const ValueKey('address-overall-rating-widget'));
    Finder reviewsWidget = find.byKey(const ValueKey('review-widget'));

    await tester.pumpAndSettle();

    expect(scaffold, findsOneWidget);
    expect(appBar, findsOneWidget);
    expect(restaurantHeroImageWidget, findsOneWidget);
    expect(categoryBusinessHoursWidget, findsOneWidget);
    expect(addressOverallRatingWidget, findsOneWidget);
    expect(reviewsWidget, findsOneWidget);
  });

  testWidgets('IconButton - onTap test', (WidgetTester tester) async {
    when(() => favoriteRestaurantsCubit.state).thenReturn(
      const FavoriteRestaurantsListState(
        status: StatusEnum.success,
        restaurantsList: [],
      ),
    );

    final state = FavoriteRestaurantsListState(
      status: StatusEnum.success,
      restaurantsList: restaurantList,
    );

    when(() => favoriteRestaurantsCubit.stream)
        .thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<FavoriteRestaurantsCubit>.value(
            value: favoriteRestaurantsCubit,
            child: RestaurantDetailView(
              restaurant: restaurantEntity,
            ),
          ),
        ),
      ),
    );

    Finder iconButton = find.byKey(const ValueKey('icon-button'));

    await tester.tap(iconButton);

    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('icon')), findsOneWidget);
  });
}
