import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/components/restaurant_item_widget.dart';
import 'package:restaurantour/components/rt_empty_widget.dart';
import 'package:restaurantour/components/rt_error_widget.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurants_list/pages/restaurants/restaurants_page.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_list_view_model.dart';
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
        home: ChangeNotifierProvider(
          create: (context) {
            final model = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);
            model.load();
            return model;
          },
          child: const RestaurantsPage(),
        ),
      );

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has data, 
  should create a [RestaurantItemWidget] for each [Restaurant]''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.text('Restaurant Name'), findsAtLeast(1));
    expect(find.bySubtype<RestaurantItemWidget>(), findsAtLeast(1));
    expect(find.byKey(const Key('restaurant-0')), findsOne);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('''when get some error while fetch the [RestaurantQueryResult], 
  should render [RTErrorWidget] to inform to the user that something fails''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTErrorWidget>(), findsAtLeast(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResult(restaurants: [])));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTEmptyWidget>(), findsAtLeast(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
