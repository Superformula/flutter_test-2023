import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/features/details/details_screen.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
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

  Widget widgetBuilder() => MaterialApp(
        localizationsDelegates: localizationsDelegates,
        debugShowCheckedModeBanner: false,
        home: DetailsScreen.create(restaurantId: Restaurant.fixture().id),
      );

  testWidgets('''when successfully load the [DetailsScreen] 
  should create a have the favorite Icon, the name of restaurant''', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(Restaurant.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResult.fixture()));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.text('Restaurant Name'), findsOne);
    expect(find.text('Open Now'), findsOne);
    expect(find.bySubtype<Icon>(), findsAtLeast(1));
  });

  testWidgets('''when successfully load the [DetailsScreen] but fails to load favorites
  should display the error screen''', (WidgetTester tester) async {
    when(() => favoritesService.loadFavorites()).thenThrow('error mock');

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTErrorWidget>(), findsOne);
  });

  testWidgets('''if successfully load the [DetailsScreen] and the restaurant is already favorite, 
  when tap on favorite button should call the service to remove from favorites passing the id''', (WidgetTester tester) async {
    final restaurantId = Restaurant.fixture().id!;
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([restaurantId]));
    when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future<void>.value());
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(Restaurant.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResult.fixture()));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('favorite-button')));
    await tester.pumpAndSettle();

    expect(find.text('Restaurant Name'), findsOne);
    expect(find.text('Open Now'), findsOne);
    expect(find.bySubtype<Icon>(), findsAtLeast(1));
    verify(() => favoritesService.removeFavorite(restaurantId)).called(1);
    verifyNever(() => favoritesService.addFavorite(any()));
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
