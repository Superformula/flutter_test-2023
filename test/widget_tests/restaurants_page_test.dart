import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
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
          create: (context) {
            final model = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);
            model.load();
            return model;
          },
          child: const RestaurantsPage(),
        ),
      );

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has data, 
  should create a [RTItemWidget] for each [Restaurant]''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.text('Restaurant Name'), findsAtLeastNWidgets(1));
    expect(find.bySubtype<RTItemWidget>(), findsAtLeastNWidgets(1));
    expect(find.byKey(const Key('restaurant-0')), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('''when get some error while fetch the [RestaurantQueryResult], 
  should render [RTErrorWidget] to inform to the user that something fails''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTErrorWidget>(), findsAtLeastNWidgets(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('''when successfully fetch the [RestaurantQueryResult] and has no data, 
  should render [RTEmptyWidget] to inform to the user that has no results''', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder());
    await tester.pumpAndSettle();

    expect(find.bySubtype<RTEmptyWidget>(), findsAtLeastNWidgets(1));
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });
}

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
