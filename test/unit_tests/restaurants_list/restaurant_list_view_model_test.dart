import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurants/restaurants_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../../mocks/mocks.dart';

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

  group('tests on restaurantViewModel.load() ->', () {
    test('''when [RestaurantViewModel] is created the [restaurantsStatus] should starts with [RestaurantStatus.loading]
   and no call to [restaurantRepository.getRestaurants] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      expect(sut.restaurantsStatus, RestaurantsStatus.loading);
      verifyNever(() => restaurantRepository.getRestaurants(offset: any(named: 'offset')));
    });

    test('when [load] is called should call once time the [getRestaurants] on [RestaurantRepository]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });

    test('when [load] get successfully the data from repository the [restaurantsStatus] should be [RestaurantStatus.content]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.restaurantsStatus, RestaurantsStatus.content);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty]
    the [restaurantsStatus] should be [RestaurantStatus.empty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.restaurantsStatus, RestaurantsStatus.empty);
    });

    test('when [load] get some error from repository the [restaurantsStatus] should be [RestaurantStatus.error]', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      expect(sut.restaurantsStatus, RestaurantsStatus.error);
    });

    test('''when [load] get some error from repository
    no more calls should be triggered to [restaurantRepository.getRestaurants]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenThrow('error mock');
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();

      verify(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).called(1);
    });
  });

  group('tests on restaurantViewModel.loadFavorites() ->', () {
    test('''when [RestaurantViewModel] is created the [favoritesStatus] should starts with [FavoriteStatus.loading]
     and no call to [favoritesService.loadFavorites] should be triggered''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      expect(sut.favoritesStatus, FavoritesStatus.loading);
      verifyNever(() => favoritesService.loadFavorites());
    });

    test('when [loadFavorites] is called should call only once time the [getRestaurants] on [FavoritesService]', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      verify(() => favoritesService.loadFavorites()).called(1);
    });

    test('''when [RestaurantViewModel] is created the [Restaurant] list has items, 
    if [loadFavorites] get successfully the data from favoritesService
    the [favoritesStatus] should be [FavoriteStatus.empty]''', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.empty);
    });

    test('''when [load] get successfully the data from repository but the [Restaurant] list is [empty], 
    when [loadFavorites] get successfully the data from favoritesService the [favoritesStatus] 
    should be [FavoriteStatus.empty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(const RestaurantQueryResultDto(restaurants: [])));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.empty);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService but finds no matching ID in the lists, 
    the [favoritesStatus] should be [FavoriteStatus.empty]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value(['another-restaurant-id']));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.empty);
    });

    test('''when [load] get successfully the data from repository 
    and [loadFavorites] get successfully the data from favoritesService and finds a matching ID in the lists, 
    the [favoritesStatus] should be [FavoriteStatus.content]''', () async {
      when(() => restaurantRepository.getRestaurants(offset: any(named: 'offset'))).thenAnswer((_) => Future.value(RestaurantQueryResultDto.fixture()));
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([RestaurantDto.fixture().id ?? '']));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.load();
      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.content);
    });

    test('''when [loadFavorites] get successfully the data from favoritesService but the list is [empty]
     the [favoritesStatus] should be [FavoriteStatus.empty]''', () async {
      when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.empty);
    });

    test('''when [loadFavorites] get some error from favoritesService
    the [favoritesStatus] should be [FavoriteStatus.error]''', () async {
      when(() => favoritesService.loadFavorites()).thenThrow('error mock');
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      expect(sut.favoritesStatus, FavoritesStatus.error);
    });

    test('''when [loadFavorites] get some error from favoritesService
    no more calls should be triggered to [favoritesService.loadFavorites]''', () async {
      when(() => favoritesService.loadFavorites()).thenThrow('error mock');
      final sut = RestaurantsViewModel(favoritesService: favoritesService, restaurantRepository: restaurantRepository);

      await sut.loadFavorites();

      verify(() => favoritesService.loadFavorites()).called(1);
    });
  });
}
