import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/restaurants/pages/favorites/favorites_page_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../../test.dart';

void main() {
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  FavoriteService favoritesService = FavoritesServiceMock();
  EventBusService eventBusService = EventBusServiceMock();

  setUp(() {
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<FavoriteService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
    when(() => eventBusService.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    reset(restaurantRepository);
    reset(favoritesService);
    GetIt.I.reset();
  });

  group('tests on restaurantViewModel.load() ->', () {
    test('''when [RestaurantViewModel] is created the [FavoritesStatus] should starts with [RestaurantStatus.loading]
   and one call to [restaurantRepository.getRestaurants] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      expect(sut.status, FavoritesStatus.loading);
      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });

    test('when [load] is called should call one more time the [getRestaurants] on [RestaurantRepository]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(2);
    });

    test('when [load] get successfully the data from repository the [FavoritesStatus] should be [RestaurantStatus.content]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();

      expect(sut.status, FavoritesStatus.content);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty]
    the [FavoritesStatus] should be [RestaurantStatus.empty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();

      expect(sut.status, FavoritesStatus.empty);
    });

    test('when [load] get some error from repository the [FavoritesStatus] should be [RestaurantStatus.error]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      expect(sut.status, FavoritesStatus.error);
    });

    test('''when [load] get some error from repository
    no more calls should be triggered to [restaurantRepository.getRestaurants]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(2);
    });
  });

  group('tests on restaurantViewModel.loadFavorites() ->', () {
    test('''when [RestaurantViewModel] is created the [favoritesStatus] should starts with [FavoriteStatus.loading]
     and no call to [favoritesService.loadFavorites] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      expect(sut.status, FavoritesStatus.loading);
      verifyNever(() => favoritesService.getFavorites());
    });

    test('when [loadFavorites] is called should call only once one more time the [getRestaurants] on [FavoritesService]', () async {
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadFavorites();

      verify(() => favoritesService.getFavorites()).called(2);
    });

    test('''when [RestaurantViewModel] is created the [Restaurant] list has no items, 
    if [loadFavorites] get successfully the data from favoritesService
    but the [Restaurant] don't have all the restaurants of favorites list
    them should get each one from repository and the favoritesStatus should be content''', () async {
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      when(() => restaurantRepository.getSingleRestaurant(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));

      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.content);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty], 
    when [loadFavorites] get successfully the data from favoritesService
    but the [Restaurant] don't have all the restaurants of favorites list
    them should get each one from repository and the favoritesStatus should be content''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();
      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.content);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService but finds no matching ID in the lists, 
    them should get each one from repository and the favoritesStatus should be content''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value(['another-restaurant-id']));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();
      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.content);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService and finds a matching ID in the lists, 
    the [favoritesStatus] should be [FavoriteStatus.content]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadRestaurants();
      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.content);
    });

    test('''when [loadFavorites] get successfully the data from favoritesService but the list is [empty]
     the [favoritesStatus] should be [FavoriteStatus.empty]''', () async {
      when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.empty);
    });

    test('''when [loadFavorites] get some error from favoritesService
    the [favoritesStatus] should be [FavoriteStatus.error]''', () async {
      when(() => favoritesService.getFavorites()).thenThrow('error mock');
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadFavorites();

      expect(sut.status, FavoritesStatus.error);
    });

    test('''when [loadFavorites] get some error from favoritesService
    no more calls should be triggered to [favoritesService.loadFavorites]''', () async {
      when(() => favoritesService.getFavorites()).thenThrow('error mock');
      final sut = FavoritesViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository, eventBus: eventBusService);

      await sut.loadFavorites();

      verify(() => favoritesService.getFavorites()).called(2);
    });
  });
}
