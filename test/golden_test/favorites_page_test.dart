import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../test.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoriteService favoritesService = FavoritesServiceMock();
  setUp(() {
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
      widget: widgetBuilder(
        ChangeNotifierProvider(
          create: (context) {
            final model = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);
            model.load();
            return model;
          },
          child: const FavoritesPage(),
        ),
      ),
    );

  testGoldens('''when successfully fetch the [RestaurantQueryResult] and has data, and also load the favorites fetch the data
  should create a [RTItemWidget] for each favorite [Restaurant]''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_content");
  });

  testGoldens('''when get some error while fetch the favorites, 
  should render [RTErrorWidget] to inform to the user that something fails''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.loadFavorites()).thenThrow('error mock');
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_error");
  });

  testGoldens('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  and also when load the favorites and has no favorites,
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_empty");
  });
}
