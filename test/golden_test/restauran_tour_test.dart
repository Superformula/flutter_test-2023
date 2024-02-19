import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/restauran_tour.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../mocks/mocks.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoriteService favoritesService = FavoritesServiceMock();
  setUp(() {
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<FavoriteService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
  });

  tearDown(() {
    reset(restaurantRepository);
    reset(favoritesService);
    GetIt.I.reset();
  });

  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
    ..addScenario(
      widget: const RestauranTour(),
    );
  autoUpdateGoldenFiles = true;

  testGoldens('when [RestaurantTour] loads should show the title on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restauran_tour_content");
  });

  testGoldens('when [RestaurantTour] loads should show the title on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('my-favorites-tab')));

    await screenMatchesGolden(tester, "restauran_tour_favorites_tab");
  });
}
