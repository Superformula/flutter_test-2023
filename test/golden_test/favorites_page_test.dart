import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurants_list/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_view_model.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

import '../mocks/mocks.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoritesService favoritesService = FavoritesServiceMock();
  setUp(() {
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
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (context) {
              final model = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);
              model.load();
              return model;
            },
            child: const FavoritesPage(),
          ),
        ),
      );

  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
    ..addScenario(
      widget: widgetBuilder(),
    );

  testGoldens('''when successfully fetch the [RestaurantQueryResult] and has data, and also load the favorites fetch the data
  should create a [RestaurantItemWidget] for each favorite [Restaurant]''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_content");
  });

  testGoldens('''when get some error while fetch the favorites, 
  should render [RTErrorWidget] to inform to the user that something fails''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    when(() => favoritesService.loadFavorites()).thenThrow('error mock');
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_error");
  });

  testGoldens('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  and also when load the favorites and has no favorites,
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResult(restaurants: [])));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
    await loadAppFonts();

    await tester.pumpDeviceBuilder(deviceBuilder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, "favorite_page_empty");
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
