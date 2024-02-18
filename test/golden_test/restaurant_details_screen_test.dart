import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurant_details/restaurant_details_screen.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../mocks/mocks.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoritesService favoritesService = FavoritesServiceMock();
  setUp(() {
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<FavoritesService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
  });

  tearDown(() {
    reset(restaurantRepository);
    reset(favoritesService);
    GetIt.I.reset();
  });

  Widget widgetBuilder() => MaterialApp(
        localizationsDelegates: localizationsDelegates,
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: RestaurantDetailsScreen.create(restaurant: Restaurant.fixture(), imageNetwork: RTImageNetworkMock())),
      );

  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(
      devices: [
        Device.iphone11.copyWith(
          size: const Size(414, 1100),
        ),
      ],
    )
    ..addScenario(
      widget: widgetBuilder(),
    );

  testGoldens('when [RestaurantDetailsScreen] loads should show the title, favorite icon, and other details', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restaurant_details_content");
  });

  testGoldens('when [RestaurantDetailsScreen] loads a favorite restaurant should show the favorite icon filled', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restaurant_details_favorite");
  });

  testGoldens('when [RestaurantDetailsScreen] loads a non favorite restaurant should show the favorite icon not filled', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restaurant_details_not_favorite");
  });

  group('toggleFavorite', () {
    testGoldens('''when [RestaurantDetailsScreen] loads a non favorite restaurant
    and tap to favorite update the status and show the favorite icon filled''', (WidgetTester tester) async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());

      await loadAppFonts();

      await tester.pumpDeviceBuilder(deviceBuilder);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('favorite-button')));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, "restaurant_details_added_favorite");
    });

    testGoldens('''when [RestaurantDetailsScreen] loads a favorite restaurant
    and tap to remove favorite update the status and show the favorite icon not filled''', (WidgetTester tester) async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
      when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());

      await loadAppFonts();

      await tester.pumpDeviceBuilder(deviceBuilder);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('favorite-button')));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, "restaurant_details_removed_favorite");
    });
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
