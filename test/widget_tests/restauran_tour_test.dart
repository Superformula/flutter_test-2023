import 'package:get_it/get_it.dart';
import 'package:restaurantour/components/rt_components.dart';
import 'package:restaurantour/features/restaurants/restaurants_screen.dart';
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

  testWidgets('when [RestaurantTour] loads should show the title on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder(const RestaurantsScreen()));

    expect(find.text('RestauranTour'), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('when [RestaurantTour] loads should show the tabs [All Restaurants] and [My Favorites] on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(widgetBuilder(const RestaurantsScreen()));

    expect(find.text('All Restaurants'), findsOneWidget);
    expect(find.text('My Favorites'), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });
}
