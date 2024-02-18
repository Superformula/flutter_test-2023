import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurants_list/restaurant_list_view_model.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorites_service.dart';

import '../../mocks/mocks.dart';

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

  group('tests on restaurantListViewModel.load() ->', () {
    test('''when [RestaurantListViewModel] is created the [status] should starts with [RestaurantListStatus.loading]
   and no call to [restaurantRepository.getRestaurants] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      expect(sut.status, RestaurantListStatus.loading);
      verifyNever(() => restaurantRepository.getRestaurants(offset: any(named: 'offset')));
    });

    test('when [load] is called should call once time the [getRestaurants] on [RestaurantRepository]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });

    test('when [load] get successfully the data from repository the [status] should be [RestaurantListStatus.content]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.status, RestaurantListStatus.content);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty]
    the [status] should be [RestaurantListStatus.restaurantsEmpty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResult(restaurants: [])));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.status, RestaurantListStatus.restaurantsEmpty);
    });

    test('when [load] get some error from repository the [status] should be [RestaurantListStatus.error]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.status, RestaurantListStatus.error);
    });

    test('''when [load] get some error from repository
    no more calls should be triggered to [restaurantRepository.getRestaurants]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });
  });

  group('tests on restaurantListViewModel.loadFavorites() ->', () {
    test('''when [RestaurantListViewModel] is created the [status] should starts with [RestaurantListStatus.loading]
     and no call to [favoritesService.loadFavorites] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      expect(sut.status, RestaurantListStatus.loading);
      verifyNever(() => favoritesService.loadFavorites());
    });

    test('when [loadFavorites] is called should call only once time the [getRestaurants] on [FavoritesService]', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      verify(() => favoritesService.loadFavorites()).called(1);
    });

    test('''when [RestaurantListViewModel] is created the [Restaurant] list has items, 
    if [loadFavorites] get successfully the data from favoritesService
    the [status] should be [RestaurantListStatus.favoritesEmpty]''', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.favoritesEmpty);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty], 
    when [loadFavorites] get successfully the data from favoritesService the [status] 
    should be [RestaurantListStatus.favoritesEmpty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResult(restaurants: [])));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.favoritesEmpty);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService but finds no matching ID in the lists, 
    the [status] should be [RestaurantListStatus.favoritesEmpty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value(['another-restaurant-id']));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.favoritesEmpty);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService and finds a matching ID in the lists, 
    the [status] should be [RestaurantListStatus.content]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResult.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([Restaurant.fixture().id ?? '']));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.content);
    });

    test('''when [loadFavorites] get successfully the data from favoritesService but the list is [empty]
     the [status] should be [RestaurantListStatus.favoritesEmpty]''', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.favoritesEmpty);
    });

    test('''when [loadFavorites] get some error from favoritesService
    the [status] should be [RestaurantListStatus.favoritesError]''', () async {
      when(() => favoritesService.loadFavorites()).thenThrow('error mock');
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.status, RestaurantListStatus.favoritesError);
    });

    test('''when [loadFavorites] get some error from favoritesService
    no more calls should be triggered to [favoritesService.loadFavorites]''', () async {
      when(() => favoritesService.loadFavorites()).thenThrow('error mock');
      final sut = RestaurantListViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      verify(() => favoritesService.loadFavorites()).called(1);
    });
  });
}
