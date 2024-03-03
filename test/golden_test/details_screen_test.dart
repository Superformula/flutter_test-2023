import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../test.dart';

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
    ..overrideDevicesForAllScenarios(devices: [Device.iphone11.copyWith(size: const Size(414, 1100))])
    ..addScenario(
      widget: widgetBuilder(DetailsScreen.create(restaurantId: RestaurantDto.fixture().id)),
    );

  testGoldens('when [DetailsScreen] loads should show the title, favorite icon, and other details', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));

    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "details_screen_content");
  });

  testGoldens('when [DetailsScreen] loads a favorite restaurant should show the favorite icon filled', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "details_screen_favorite");
  });

  testGoldens('when [DetailsScreen] loads a non favorite restaurant should show the favorite icon not filled', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "details_screen_not_favorite");
  });

  group('toggleFavorite', () {
    testGoldens('''when [DetailsScreen] loads a non favorite restaurant
    and tap to favorite update the status and show the favorite icon filled''', (WidgetTester tester) async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());
      when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
      when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));
      await loadAppFonts();

      await tester.pumpDeviceBuilder(deviceBuilder);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('favorite-button')));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, "details_screen_added_favorite");
    });

    testGoldens('''when [DetailsScreen] loads a favorite restaurant
    and tap to remove favorite update the status and show the favorite icon not filled''', (WidgetTester tester) async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());
      when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
      when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));

      await loadAppFonts();

      await tester.pumpDeviceBuilder(deviceBuilder);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('favorite-button')));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, "details_screen_removed_favorite");
    });
  });
}
