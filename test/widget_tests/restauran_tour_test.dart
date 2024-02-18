import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
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

  testWidgets('when [RestaurantTour] loads should show the title on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));

    await tester.pumpWidget(const RestauranTour());

    expect(find.text('RestauranTour'), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });

  testWidgets('when [RestaurantTour] loads should show the tabs [All Restaurants] and [My Favorites] on the page and fetch the data', (WidgetTester tester) async {
    when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));

    await tester.pumpWidget(const RestauranTour());

    expect(find.text('All Restaurants'), findsOneWidget);
    expect(find.text('My Favorites'), findsOneWidget);
    verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
  });
}
