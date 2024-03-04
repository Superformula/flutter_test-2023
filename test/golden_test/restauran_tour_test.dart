import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/restaurants_screen.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../test.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoriteService favoritesService = FavoritesServiceMock();
  EventBusService eventBusService = EventBusServiceMock();

  setUp(() {
    GetIt.I.registerFactory<EventBusService>(() => eventBusService);
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<FavoriteService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
    when(() => eventBusService.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    reset(restaurantRepository);
    reset(favoritesService);
    GetIt.I.reset();
  });

  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
    ..addScenario(
      widget: widgetBuilder(const RestaurantsScreen()),
    );

  testGoldens('when [RestaurantTour] loads should show the title on the page and fetch the data for all restaurants', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "restauran_tour_content");
  });

  testGoldens('when [RestaurantTour] loads should show the title on the page and fetch the data for all favorites', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('my-favorites-tab')));

    await screenMatchesGolden(tester, "restauran_tour_favorites_tab");
  });
}
