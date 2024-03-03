import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/restaurants/restaurants_page_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../../test.dart';

void main() {
  EventBusService eventBusService = EventBusServiceMock();
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoriteService favoritesService = FavoritesServiceMock();

  setUp(() {
    GetIt.I.registerFactory<EventBusService>(() => eventBusService);
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<FavoriteService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
  });

  tearDown(() {
    reset(restaurantRepository);
    reset(favoritesService);
    GetIt.I.reset();
  });

  group('tests on restaurantViewModel.load() ->', () {
    test('''when [RestaurantViewModel] is created the [restaurantsStatus] should starts with [RestaurantStatus.loading]
   and should call to [restaurantRepository.getRestaurants]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      expect(sut.restaurantsStatus, RestaurantsStatus.loading);
      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });

    test('when [load] is called should call once more time the [getRestaurants] on [RestaurantRepository]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      await sut.loadRestaurants();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(2);
    });

    test('when [load] get successfully the data from repository the [restaurantsStatus] should be [RestaurantStatus.content]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      await sut.loadRestaurants();

      expect(sut.restaurantsStatus, RestaurantsStatus.content);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty]
    the [restaurantsStatus] should be [RestaurantStatus.empty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      await sut.loadRestaurants();

      expect(sut.restaurantsStatus, RestaurantsStatus.empty);
    });

    test('when [load] get some error from repository the [restaurantsStatus] should be [RestaurantStatus.error]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      await sut.loadRestaurants();

      expect(sut.restaurantsStatus, RestaurantsStatus.error);
    });

    test('''when [load] get some error from repository
    no more calls should be triggered to [restaurantRepository.getRestaurants]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(restaurantRepository: restaurantRepository);

      await sut.loadRestaurants();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(2);
    });
  });
}
