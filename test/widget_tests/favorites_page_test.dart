import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:restaurantour/theme/theme.dart';

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

  Widget widgetBuilder() => MaterialApp(
        localizationsDelegates: localizationsDelegates,
        debugShowCheckedModeBanner: false,
        theme: RTThemeData.themeData,
        home: ChangeNotifierProvider(
          create: (context) => FavoritesViewModel(
            favoritesService: favoritesService,
            restaurantRepository: restaurantRepository,
            eventBus: EventBusService(),
          ),
          child: const FavoritesPage(),
        ),
      );

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has data, and also load the favorites fetch the data
  should create a [RTItemWidget] for each favorite [Restaurant]''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.text('Restaurant Name'), findsAtLeastNWidgets(1));
    expect(find.bySubtype<RTItemWidget>(), findsAtLeastNWidgets(1));
    expect(find.byKey(const Key('favorite-restaurant-0')), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    verify(() => favoritesService.getFavorites()).called(1);
  });

  testWidgets('''when get some error while fetch the favorites, 
  should render [RTErrorWidget] to inform to the user that something fails''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenThrow('error mock');

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTErrorWidget>(), findsAtLeastNWidgets(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    verify(() => favoritesService.getFavorites()).called(1);
  });

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  and also when load the favorites and has no favorites,
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTEmptyWidget>(), findsAtLeastNWidgets(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    verify(() => favoritesService.getFavorites()).called(1);
  });

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has data, 
  but when load the favorites and has no favorites,
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTEmptyWidget>(), findsAtLeastNWidgets(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    verify(() => favoritesService.getFavorites()).called(1);
  });

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  but when load the favorites and has favorites,
  but the [Restaurant] don't have all the restaurants of favorites list
  them should get each one from repository and the favoritesStatus should be content''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTItemWidget>(), findsAtLeastNWidgets(1));
    expect(find.byKey(const Key('favorite-restaurant-0')), findsOneWidget);
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
