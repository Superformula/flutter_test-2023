import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

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

  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
    ..addScenario(
      widget: const RestauranTour(),
    );

  testGoldens('when [RestaurantTour] loads should show the title on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restauran_tour_content");
  });
}
